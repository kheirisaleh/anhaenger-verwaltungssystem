import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_checkbox.dart';
import '../../../core/design/widgets/app_data_table.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_icon_button.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import '../../../core/design/widgets/app_search_field.dart';
import '../../../core/design/widgets/app_select_field.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/design/widgets/app_status_badge.dart';
import '../../../data/models/enums.dart';
import '../../../data/models/trailer.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/run_action.dart';
import '../../../shared/scoped_navigation.dart';
import '../application/trailer_list_controller.dart';
import 'trailer_detail_page.dart';
import 'trailer_dialogs.dart';

class TrailersPage extends StatefulWidget {
  const TrailersPage({super.key});

  @override
  State<TrailersPage> createState() => _TrailersPageState();
}

class _TrailersPageState extends State<TrailersPage> {
  TrailerListController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= TrailerListController(AppScope.of(context).trailers);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TrailerListController controller = _controller!;
    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) => AppPageScaffold(
        title: AppStrings.navTrailers,
        actions: <Widget>[
          AppButton(
            label: AppStrings.trailerCreate,
            icon: AppIcons.add,
            variant: AppButtonVariant.primary,
            onPressed: () => _create(context),
          ),
        ],
        filterBar: _buildFilters(controller),
        content: StreamBuilder<List<Trailer>>(
          stream: controller.trailers,
          builder:
              (BuildContext context, AsyncSnapshot<List<Trailer>> snapshot) {
                if (snapshot.hasError) {
                  return const AppErrorState();
                }
                final List<Trailer>? trailers = snapshot.data;
                if (trailers == null) {
                  return const AppLoadingState();
                }
                if (trailers.isEmpty) {
                  return controller.hasFilter
                      ? const AppEmptyState(
                          title: AppStrings.navTrailers,
                          description: AppStrings.emptySearch,
                          icon: AppIcons.search,
                        )
                      : AppEmptyState(
                          title: AppStrings.navTrailers,
                          description: AppStrings.emptyTrailers,
                          actionLabel: AppStrings.trailerCreate,
                          onAction: () => _create(context),
                        );
                }
                return _buildTable(context, trailers);
              },
        ),
      ),
    );
  }

  Widget _buildFilters(TrailerListController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: AppSearchField(
            placeholder: AppStrings.trailerSearch,
            onChanged: controller.setSearch,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          flex: 2,
          child: AppSelectField<TrailerStatus?>(
            label: AppStrings.fieldStatus,
            value: controller.status,
            placeholder: AppStrings.filterAll,
            options: <AppSelectOption<TrailerStatus?>>[
              const AppSelectOption<TrailerStatus?>(
                value: null,
                label: AppStrings.filterAll,
              ),
              for (final TrailerStatus status in TrailerStatus.values)
                AppSelectOption<TrailerStatus?>(
                  value: status,
                  label: status.label,
                ),
            ],
            onChanged: controller.setStatus,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: AppCheckbox(
            label: AppStrings.filterShowArchived,
            value: controller.includeArchived,
            onChanged: controller.setIncludeArchived,
          ),
        ),
      ],
    );
  }

  Widget _buildTable(BuildContext context, List<Trailer> trailers) {
    return AppDataTable<Trailer>(
      rows: trailers,
      onRowTap: (Trailer trailer) => _open(context, trailer),
      actionsWidth: 140,
      columns: <AppDataColumn<Trailer>>[
        AppDataColumn<Trailer>(
          label: AppStrings.fieldInternalCode,
          cellBuilder: (Trailer t) => AppTableText(t.internalCode),
        ),
        AppDataColumn<Trailer>(
          label: AppStrings.fieldLicensePlate,
          cellBuilder: (Trailer t) => AppTableText(t.licensePlate),
        ),
        AppDataColumn<Trailer>(
          label: AppStrings.fieldTrailerType,
          cellBuilder: (Trailer t) => AppTableText(t.type.name),
        ),
        AppDataColumn<Trailer>(
          label: AppStrings.fieldStatus,
          cellBuilder: (Trailer t) => t.isArchived
              ? const AppTableText(AppStrings.archived, isMuted: true)
              : AppStatusBadge.trailer(t.status),
        ),
        AppDataColumn<Trailer>(
          label: AppStrings.fieldLocation,
          flex: 2,
          cellBuilder: (Trailer t) =>
              AppTableText(t.location.address ?? '–', isMuted: true),
        ),
      ],
      actionsBuilder: (Trailer trailer) => <Widget>[
        AppIconButton(
          icon: AppIcons.edit,
          tooltip: AppStrings.actionEdit,
          onPressed: () => _edit(context, trailer),
        ),
        if (trailer.isArchived)
          AppIconButton(
            icon: AppIcons.restore,
            tooltip: AppStrings.actionRestore,
            onPressed: () => _restore(context, trailer),
          )
        else
          AppIconButton(
            icon: AppIcons.delete,
            tooltip: AppStrings.actionDelete,
            isDestructive: true,
            onPressed: () => _archive(context, trailer),
          ),
        AppIconButton(
          icon: AppIcons.open,
          tooltip: AppStrings.actionOpen,
          onPressed: () => _open(context, trailer),
        ),
      ],
    );
  }

  Future<void> _create(BuildContext context) async {
    final bool? saved = await showScopedDialog<bool>(
      context,
      (BuildContext context) => const TrailerFormDialog(),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
  }

  Future<void> _edit(BuildContext context, Trailer trailer) async {
    final bool? saved = await showScopedDialog<bool>(
      context,
      (BuildContext context) => TrailerFormDialog(trailer: trailer),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
  }

  Future<void> _archive(BuildContext context, Trailer trailer) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool confirmed = await AppDialog.confirmDelete(
      context,
      message: AppStrings.trailerDeleteConfirm,
    );
    if (!confirmed || !context.mounted) {
      return;
    }
    await runAction(
      context,
      () => dependencies.trailers.archive(trailer.id),
      successMessage: AppStrings.deletedArchived,
    );
  }

  Future<void> _restore(BuildContext context, Trailer trailer) async {
    final AppDependencies dependencies = AppScope.of(context);
    await runAction(
      context,
      () => dependencies.trailers.restore(trailer.id),
      successMessage: AppStrings.restored,
    );
  }

  void _open(BuildContext context, Trailer trailer) {
    pushScopedPage<void>(
      context,
      (BuildContext context) => TrailerDetailPage(trailerId: trailer.id),
    );
  }
}

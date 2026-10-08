import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_checkbox.dart';
import '../../../core/design/widgets/app_data_table.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_filter_chips.dart';
import '../../../core/design/widgets/app_icon_button.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import '../../../core/design/widgets/app_search_field.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/design/widgets/app_status_badge.dart';
import '../../../data/models/enums.dart';
import '../../../data/models/trailer.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/run_action.dart';
import '../../../shared/scoped_navigation.dart';
import '../../contracts/presentation/contract_form_dialog.dart';
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
        filterBar: Row(
          children: <Widget>[
            Expanded(
              child: AppSearchField(
                placeholder: AppStrings.trailerSearch,
                onChanged: controller.setSearch,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            AppCheckbox(
              label: AppStrings.filterShowArchived,
              value: controller.includeArchived,
              onChanged: controller.setIncludeArchived,
            ),
          ],
        ),
        content: StreamBuilder<List<Trailer>>(
          stream: controller.trailers,
          builder:
              (BuildContext context, AsyncSnapshot<List<Trailer>> snapshot) {
                if (snapshot.hasError) {
                  return const AppErrorState();
                }
                final List<Trailer>? all = snapshot.data;
                if (all == null) {
                  return const AppLoadingState();
                }
                if (all.isEmpty && !controller.hasFilter) {
                  return AppEmptyState(
                    title: AppStrings.navTrailers,
                    description: AppStrings.emptyTrailers,
                    actionLabel: AppStrings.trailerCreate,
                    onAction: () => _create(context),
                  );
                }
                return _buildList(context, controller, all);
              },
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    TrailerListController controller,
    List<Trailer> all,
  ) {
    final Map<TrailerStatus, int> counts = controller.counts(all);
    final List<Trailer> visible = controller.visible(all);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppFilterChips<TrailerStatus?>(
          selected: controller.status,
          onSelected: controller.setStatus,
          chips: <AppFilterChip<TrailerStatus?>>[
            AppFilterChip<TrailerStatus?>(
              value: null,
              label: AppStrings.filterAll,
              count: controller.matchingSearch(all).length,
            ),
            for (final TrailerStatus status in TrailerStatus.values)
              AppFilterChip<TrailerStatus?>(
                value: status,
                label: status.label,
                count: counts[status],
                color: _statusColor(status),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          '${visible.length} ${AppStrings.resultsOf} ${all.length}',
          style: AppText.caption,
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: visible.isEmpty
              ? const AppEmptyState(
                  title: AppStrings.navTrailers,
                  description: AppStrings.emptySearch,
                  icon: AppIcons.search,
                )
              : _buildTable(context, visible),
        ),
      ],
    );
  }

  Widget _buildTable(BuildContext context, List<Trailer> trailers) {
    return AppDataTable<Trailer>(
      rows: trailers,
      onRowTap: (Trailer trailer) => _open(context, trailer),
      actionsWidth: 176,
      columns: <AppDataColumn<Trailer>>[
        AppDataColumn<Trailer>(
          label: AppStrings.fieldInternalCode,
          cellBuilder: (Trailer t) => AppTableText(t.internalCode),
          sortValue: (Trailer t) => t.internalCode.toLowerCase(),
        ),
        AppDataColumn<Trailer>(
          label: AppStrings.fieldLicensePlate,
          cellBuilder: (Trailer t) => AppTableText(t.licensePlate),
          sortValue: (Trailer t) => t.licensePlate,
        ),
        AppDataColumn<Trailer>(
          label: AppStrings.fieldTrailerType,
          cellBuilder: (Trailer t) => AppTableText(t.type.name),
          sortValue: (Trailer t) => t.type.name,
        ),
        AppDataColumn<Trailer>(
          label: AppStrings.fieldStatus,
          cellBuilder: (Trailer t) => t.isArchived
              ? const AppTableText(AppStrings.archived, isMuted: true)
              : AppStatusBadge.trailer(t.status),
          sortValue: (Trailer t) => t.status.index,
        ),
        AppDataColumn<Trailer>(
          label: AppStrings.fieldLocation,
          flex: 2,
          cellBuilder: (Trailer t) =>
              AppTableText(t.location.address ?? AppStrings.none, isMuted: true),
          sortValue: (Trailer t) => t.location.address ?? '',
        ),
      ],
      actionsBuilder: (Trailer trailer) => <Widget>[
        if (!trailer.isArchived)
          AppIconButton(
            icon: AppIcons.rent,
            tooltip: AppStrings.trailerRent,
            onPressed: () => _rent(context, trailer),
          ),
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

  Color _statusColor(TrailerStatus status) {
    return switch (status) {
      TrailerStatus.available => AppColors.statusAvailable,
      TrailerStatus.rented => AppColors.statusRented,
      TrailerStatus.maintenance => AppColors.statusMaintenance,
      TrailerStatus.blocked => AppColors.statusBlocked,
    };
  }

  Future<void> _create(BuildContext context) async {
    final Object? created = await showScopedDialog<Object>(
      context,
      (BuildContext context) => const TrailerFormDialog(),
    );
    if (created is Trailer && context.mounted) {
      showSavedIfTrue(context, true);
      _open(context, created);
    }
  }

  Future<void> _edit(BuildContext context, Trailer trailer) async {
    final Object? saved = await showScopedDialog<Object>(
      context,
      (BuildContext context) => TrailerFormDialog(trailer: trailer),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved != null);
    }
  }

  Future<void> _rent(BuildContext context, Trailer trailer) async {
    final Object? saved = await showScopedDialog<Object>(
      context,
      (BuildContext context) => ContractFormDialog(trailerId: trailer.id),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved != null);
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

import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_card.dart';
import '../../../core/design/widgets/app_charts.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/design/widgets/app_status_badge.dart';
import '../../../core/formatting/app_formats.dart';
import '../../../data/models/photo.dart';
import '../../../data/models/trailer.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/photo_gallery.dart';
import '../../../shared/run_action.dart';
import '../../../shared/scoped_navigation.dart';
import '../../contracts/presentation/contract_table.dart';
import '../../damages/presentation/damage_table.dart';
import 'trailer_dialogs.dart';

class TrailerDetailPage extends StatefulWidget {
  const TrailerDetailPage({super.key, required this.trailerId});

  final int trailerId;

  @override
  State<TrailerDetailPage> createState() => _TrailerDetailPageState();
}

class _TrailerDetailPageState extends State<TrailerDetailPage> {
  Stream<Trailer?>? _trailer;
  Stream<List<TrailerStatusChange>>? _history;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppDependencies dependencies = AppScope.of(context);
    _trailer ??= dependencies.trailers.watchById(widget.trailerId);
    _history ??= dependencies.trailers.watchStatusHistory(widget.trailerId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Trailer?>(
      stream: _trailer,
      builder: (BuildContext context, AsyncSnapshot<Trailer?> snapshot) {
        final Trailer? trailer = snapshot.data;
        if (snapshot.hasError) {
          return _frame(context, const AppErrorState());
        }
        if (trailer == null) {
          return _frame(
            context,
            snapshot.connectionState == ConnectionState.active
                ? const AppErrorState(message: AppStrings.errorNotFound)
                : const AppLoadingState(),
          );
        }
        return AppPageScaffold(
          title: '${trailer.internalCode} · ${trailer.licensePlate}',
          onBack: () => Navigator.of(context).pop(),
          actions: _actions(context, trailer),
          content: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _buildMain(trailer)),
                const SizedBox(width: AppSpacing.lg),
                SizedBox(
                  width: AppSizes.detailSidebarWidth,
                  child: _buildSidebar(trailer),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _frame(BuildContext context, Widget content) {
    return AppPageScaffold(
      title: AppStrings.navTrailers,
      onBack: () => Navigator.of(context).pop(),
      content: content,
    );
  }

  List<Widget> _actions(BuildContext context, Trailer trailer) {
    return <Widget>[
      AppButton(
        label: AppStrings.trailerChangeStatus,
        icon: AppIcons.status,
        onPressed: trailer.isArchived
            ? null
            : () => _openDialog(
                context,
                (BuildContext context) => TrailerStatusDialog(trailer: trailer),
              ),
      ),
      AppButton(
        label: AppStrings.trailerChangeLocation,
        icon: AppIcons.location,
        onPressed: () => _openDialog(
          context,
          (BuildContext context) => TrailerLocationDialog(trailer: trailer),
        ),
      ),
      AppButton(
        label: AppStrings.actionEdit,
        icon: AppIcons.edit,
        onPressed: () => _openDialog(
          context,
          (BuildContext context) => TrailerFormDialog(trailer: trailer),
        ),
      ),
      if (trailer.isArchived)
        AppButton(
          label: AppStrings.actionRestore,
          icon: AppIcons.restore,
          onPressed: () => _restore(context, trailer),
        )
      else
        AppButton(
          label: AppStrings.actionDelete,
          icon: AppIcons.delete,
          variant: AppButtonVariant.danger,
          onPressed: () => _archive(context, trailer),
        ),
    ];
  }

  Widget _buildMain(Trailer trailer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppCard(
          title: AppStrings.sectionPhotos,
          child: PhotoGallery(owner: TrailerPhotoOwner(trailer.id)),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          title: AppStrings.sectionDamageHistory,
          child: DamageTable(trailerId: trailer.id, shrinkWrap: true),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          title: AppStrings.sectionContracts,
          child: ContractTable(trailerId: trailer.id, shrinkWrap: true),
        ),
      ],
    );
  }

  Widget _buildSidebar(Trailer trailer) {
    final TrailerLocation location = trailer.location;
    final DateTime? locationUpdated = location.updatedAt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppCard(
          title: AppStrings.sectionOverview,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: trailer.isArchived
                    ? const Text(AppStrings.archived, style: AppText.bodyMuted)
                    : AppStatusBadge.trailer(trailer.status),
              ),
              AppKeyValue(
                label: AppStrings.fieldInternalCode,
                value: trailer.internalCode,
              ),
              AppKeyValue(
                label: AppStrings.fieldLicensePlate,
                value: trailer.licensePlate,
              ),
              AppKeyValue(
                label: AppStrings.fieldTrailerType,
                value: trailer.type.name,
              ),
              AppKeyValue(
                label: AppStrings.fieldCreatedAt,
                value: AppFormats.date(trailer.createdAt),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          title: AppStrings.fieldLocation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppKeyValue(
                label: AppStrings.fieldAddress,
                value: location.address ?? AppStrings.none,
              ),
              AppKeyValue(
                label: AppStrings.fieldCoordinates,
                value: location.hasCoordinates
                    ? '${location.latitude}, ${location.longitude}'
                    : AppStrings.none,
              ),
              AppKeyValue(
                label: AppStrings.fieldUpdatedAt,
                value: locationUpdated == null
                    ? AppStrings.none
                    : AppFormats.dateTime(locationUpdated),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          title: AppStrings.sectionStatusHistory,
          child: StreamBuilder<List<TrailerStatusChange>>(
            stream: _history,
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<List<TrailerStatusChange>> snapshot,
                ) {
                  final List<TrailerStatusChange> changes =
                      snapshot.data ?? const <TrailerStatusChange>[];
                  if (changes.isEmpty) {
                    return const Text(
                      AppStrings.none,
                      style: AppText.bodyMuted,
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (final TrailerStatusChange change in changes)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.sm,
                          ),
                          child: Row(
                            children: <Widget>[
                              AppStatusBadge.trailer(change.newStatus),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  '${AppFormats.dateTime(change.changedAt)}\n'
                                  '${change.changedByName}',
                                  style: AppText.caption,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
          ),
        ),
      ],
    );
  }

  Future<void> _openDialog(BuildContext context, WidgetBuilder builder) async {
    final bool? saved = await showScopedDialog<bool>(context, builder);
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
}

import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_data_table.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_icon_button.dart';
import '../../../core/design/widgets/app_select_field.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/formatting/app_formats.dart';
import '../../../data/models/damage_record.dart';
import '../../../data/models/enums.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/lookup_builder.dart';
import '../../../shared/run_action.dart';
import '../../../shared/scoped_navigation.dart';
import '../application/damage_list_controller.dart';
import 'damage_form_dialog.dart';

class DamageTable extends StatefulWidget {
  const DamageTable({super.key, this.trailerId, this.shrinkWrap = false});

  final int? trailerId;
  final bool shrinkWrap;

  @override
  State<DamageTable> createState() => _DamageTableState();
}

class _DamageTableState extends State<DamageTable> {
  DamageListController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= DamageListController(
      AppScope.of(context).damages,
      trailerId: widget.trailerId,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DamageListController controller = _controller!;
    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: widget.shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
        children: <Widget>[
          _buildFilters(context, controller),
          const SizedBox(height: AppSpacing.md),
          if (widget.shrinkWrap)
            _buildList(context, controller)
          else
            Expanded(child: _buildList(context, controller)),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context, DamageListController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: AppSelectField<DamageType?>(
            label: AppStrings.fieldDamageType,
            value: controller.damageType,
            placeholder: AppStrings.filterAll,
            options: <AppSelectOption<DamageType?>>[
              const AppSelectOption<DamageType?>(
                value: null,
                label: AppStrings.filterAll,
              ),
              for (final DamageType type in DamageType.values)
                AppSelectOption<DamageType?>(value: type, label: type.label),
            ],
            onChanged: controller.setDamageType,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: AppSelectField<DamagePeriod>(
            label: AppStrings.fieldPeriod,
            value: controller.period,
            options: const <AppSelectOption<DamagePeriod>>[
              AppSelectOption<DamagePeriod>(
                value: DamagePeriod.all,
                label: AppStrings.periodAll,
              ),
              AppSelectOption<DamagePeriod>(
                value: DamagePeriod.last30Days,
                label: AppStrings.periodLast30Days,
              ),
              AppSelectOption<DamagePeriod>(
                value: DamagePeriod.last12Months,
                label: AppStrings.periodLast12Months,
              ),
              AppSelectOption<DamagePeriod>(
                value: DamagePeriod.thisYear,
                label: AppStrings.periodThisYear,
              ),
            ],
            onChanged: controller.setPeriod,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        AppButton(
          label: AppStrings.damageCreate,
          icon: AppIcons.add,
          variant: widget.shrinkWrap
              ? AppButtonVariant.secondary
              : AppButtonVariant.primary,
          onPressed: () => _openForm(context),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context, DamageListController controller) {
    return LookupBuilder(
      builder: (BuildContext context, Lookups lookups) =>
          StreamBuilder<List<DamageRecord>>(
            stream: controller.damages,
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<List<DamageRecord>> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const AppErrorState();
                  }
                  final List<DamageRecord>? damages = snapshot.data;
                  if (damages == null) {
                    return const SizedBox(
                      height: 120,
                      child: AppLoadingState(),
                    );
                  }
                  if (damages.isEmpty) {
                    return SizedBox(
                      height: 200,
                      child: AppEmptyState(
                        title: AppStrings.navDamages,
                        description: controller.hasFilter
                            ? AppStrings.emptySearch
                            : AppStrings.emptyDamages,
                        icon: AppIcons.damages,
                      ),
                    );
                  }
                  return _buildTable(context, damages, lookups);
                },
          ),
    );
  }

  Widget _buildTable(
    BuildContext context,
    List<DamageRecord> damages,
    Lookups lookups,
  ) {
    return AppDataTable<DamageRecord>(
      rows: damages,
      shrinkWrap: widget.shrinkWrap,
      onRowTap: (DamageRecord damage) => _openForm(context, damage: damage),
      actionsWidth: 96,
      columns: <AppDataColumn<DamageRecord>>[
        AppDataColumn<DamageRecord>(
          label: AppStrings.fieldDate,
          cellBuilder: (DamageRecord d) =>
              AppTableText(AppFormats.date(d.eventDate)),
        ),
        if (widget.trailerId == null)
          AppDataColumn<DamageRecord>(
            label: AppStrings.fieldTrailer,
            flex: 2,
            cellBuilder: (DamageRecord d) =>
                AppTableText(lookups.trailerName(d.trailerId)),
          ),
        AppDataColumn<DamageRecord>(
          label: AppStrings.fieldDamageType,
          cellBuilder: (DamageRecord d) => AppTableText(d.damageType.label),
        ),
        AppDataColumn<DamageRecord>(
          label: AppStrings.fieldCausedBy,
          cellBuilder: (DamageRecord d) => AppTableText(
            d.customerId == null
                ? d.causedBy.label
                : lookups.customerName(d.customerId),
          ),
        ),
        AppDataColumn<DamageRecord>(
          label: AppStrings.fieldDescription,
          flex: 3,
          cellBuilder: (DamageRecord d) =>
              AppTableText(d.description, isMuted: true),
        ),
        AppDataColumn<DamageRecord>(
          label: AppStrings.fieldCost,
          isNumeric: true,
          cellBuilder: (DamageRecord d) {
            final int? cost = d.costCents;
            return AppTableText(
              cost == null ? AppStrings.none : AppFormats.currencyFromCents(cost),
            );
          },
        ),
      ],
      actionsBuilder: (DamageRecord damage) => <Widget>[
        AppIconButton(
          icon: AppIcons.edit,
          tooltip: AppStrings.actionEdit,
          onPressed: () => _openForm(context, damage: damage),
        ),
        AppIconButton(
          icon: AppIcons.delete,
          tooltip: AppStrings.actionDelete,
          isDestructive: true,
          onPressed: () => _delete(context, damage),
        ),
      ],
    );
  }

  Future<void> _openForm(BuildContext context, {DamageRecord? damage}) async {
    final bool? saved = await showScopedDialog<bool>(
      context,
      (BuildContext context) =>
          DamageFormDialog(damage: damage, trailerId: widget.trailerId),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
  }

  Future<void> _delete(BuildContext context, DamageRecord damage) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool confirmed = await AppDialog.confirmDelete(context);
    if (!confirmed || !context.mounted) {
      return;
    }
    await runAction(
      context,
      () => dependencies.damages.delete(damage.id),
      successMessage: AppStrings.deleted,
    );
  }
}

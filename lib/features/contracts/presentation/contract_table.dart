import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_data_table.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_filter_chips.dart';
import '../../../core/design/widgets/app_icon_button.dart';
import '../../../core/design/widgets/app_search_field.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/design/widgets/app_status_badge.dart';
import '../../../core/formatting/app_formats.dart';
import '../../../data/models/enums.dart';
import '../../../data/models/rental_contract.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/lookup_builder.dart';
import '../../../shared/run_action.dart';
import '../../../shared/scoped_navigation.dart';
import '../application/contract_list_controller.dart';
import 'contract_form_dialog.dart';

class ContractTable extends StatefulWidget {
  const ContractTable({
    super.key,
    this.customerId,
    this.trailerId,
    this.shrinkWrap = false,
  });

  final int? customerId;
  final int? trailerId;
  final bool shrinkWrap;

  @override
  State<ContractTable> createState() => _ContractTableState();
}

class _ContractTableState extends State<ContractTable> {
  ContractListController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= ContractListController(
      AppScope.of(context).contracts,
      customerId: widget.customerId,
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
    final ContractListController controller = _controller!;
    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) => LookupBuilder(
        builder: (BuildContext context, Lookups lookups) =>
            StreamBuilder<List<RentalContract>>(
              stream: controller.contracts,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<List<RentalContract>> snapshot,
                  ) {
                    if (snapshot.hasError) {
                      return const AppErrorState();
                    }
                    final List<RentalContract>? all = snapshot.data;
                    if (all == null) {
                      return const SizedBox(
                        height: 120,
                        child: AppLoadingState(),
                      );
                    }
                    return _buildContent(context, controller, lookups, all);
                  },
            ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ContractListController controller,
    Lookups lookups,
    List<RentalContract> all,
  ) {
    final List<RentalContract> searched = controller.matchingSearch(
      all,
      (RentalContract c) =>
          '${lookups.customerName(c.customerId)} '
          '${lookups.trailerName(c.trailerId)}',
    );
    final List<RentalContract> visible = controller.visible(searched);
    final Widget body = visible.isEmpty
        ? SizedBox(
            height: 200,
            child: AppEmptyState(
              title: AppStrings.navContracts,
              description: controller.hasFilter
                  ? AppStrings.emptySearch
                  : AppStrings.emptyContracts,
              icon: AppIcons.contracts,
              actionLabel: controller.hasFilter
                  ? null
                  : AppStrings.contractCreate,
              onAction: () => _openForm(context),
            ),
          )
        : _buildTable(context, controller, visible, lookups);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: widget.shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: AppSearchField(
                placeholder: AppStrings.contractSearch,
                onChanged: controller.setSearch,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            AppButton(
              label: AppStrings.contractCreate,
              icon: AppIcons.add,
              variant: widget.shrinkWrap
                  ? AppButtonVariant.secondary
                  : AppButtonVariant.primary,
              onPressed: () => _openForm(context),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        AppFilterChips<ContractFilter>(
          selected: controller.filter,
          onSelected: controller.setFilter,
          chips: <AppFilterChip<ContractFilter>>[
            for (final ContractFilter filter in ContractFilter.values)
              AppFilterChip<ContractFilter>(
                value: filter,
                label: _filterLabel(filter),
                count: controller.count(searched, filter),
                color: _filterColor(filter),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (widget.shrinkWrap) body else Expanded(child: body),
      ],
    );
  }

  Widget _buildTable(
    BuildContext context,
    ContractListController controller,
    List<RentalContract> contracts,
    Lookups lookups,
  ) {
    final DateTime now = controller.now();
    return AppDataTable<RentalContract>(
      rows: contracts,
      shrinkWrap: widget.shrinkWrap,
      onRowTap: (RentalContract contract) => contract.isEditable
          ? _openForm(context, contract: contract)
          : null,
      actionsWidth: 140,
      columns: <AppDataColumn<RentalContract>>[
        AppDataColumn<RentalContract>(
          label: AppStrings.fieldNumber,
          cellBuilder: (RentalContract c) => AppTableText('#${c.id}'),
          sortValue: (RentalContract c) => c.id,
        ),
        if (widget.customerId == null)
          AppDataColumn<RentalContract>(
            label: AppStrings.fieldCustomer,
            flex: 2,
            cellBuilder: (RentalContract c) =>
                AppTableText(lookups.customerName(c.customerId)),
            sortValue: (RentalContract c) =>
                lookups.customerName(c.customerId),
          ),
        if (widget.trailerId == null)
          AppDataColumn<RentalContract>(
            label: AppStrings.fieldTrailer,
            flex: 2,
            cellBuilder: (RentalContract c) =>
                AppTableText(lookups.trailerName(c.trailerId)),
            sortValue: (RentalContract c) => lookups.trailerName(c.trailerId),
          ),
        AppDataColumn<RentalContract>(
          label: AppStrings.fieldPeriod,
          flex: 3,
          cellBuilder: (RentalContract c) => _periodCell(c, now),
          sortValue: (RentalContract c) => c.startAt.millisecondsSinceEpoch,
        ),
        AppDataColumn<RentalContract>(
          label: AppStrings.fieldPrice,
          isNumeric: true,
          cellBuilder: (RentalContract c) =>
              AppTableText(AppFormats.currencyFromCents(c.priceCents)),
          sortValue: (RentalContract c) => c.priceCents,
        ),
        AppDataColumn<RentalContract>(
          label: AppStrings.fieldStatus,
          cellBuilder: (RentalContract c) => AppStatusBadge.contract(c.status),
          sortValue: (RentalContract c) => c.status.index,
        ),
      ],
      actionsBuilder: (RentalContract contract) => <Widget>[
        if (contract.status == ContractStatus.planned) ...<Widget>[
          AppIconButton(
            icon: AppIcons.handOver,
            tooltip: AppStrings.contractHandOver,
            onPressed: () => _handOver(context, contract),
          ),
          AppIconButton(
            icon: AppIcons.edit,
            tooltip: AppStrings.actionEdit,
            onPressed: () => _openForm(context, contract: contract),
          ),
          AppIconButton(
            icon: AppIcons.cancel,
            tooltip: AppStrings.contractCancel,
            isDestructive: true,
            onPressed: () => _cancel(context, contract),
          ),
        ],
        if (contract.status == ContractStatus.active)
          AppIconButton(
            icon: AppIcons.returnTrailer,
            tooltip: AppStrings.contractReturn,
            onPressed: () => _return(context, contract),
          ),
      ],
    );
  }

  Widget _periodCell(RentalContract contract, DateTime now) {
    final bool overdue = contract.isOverdue(now);
    final bool due = !overdue && contract.needsAttention(now);
    final Color color = overdue
        ? AppColors.danger
        : due
        ? AppColors.warning
        : AppColors.textSecondary;
    final String prefix = overdue
        ? '${AppStrings.contractOverdue} · '
        : due
        ? '${AppStrings.contractDueToday} · '
        : '';
    return Text(
      '$prefix${AppFormats.dateTime(contract.startAt)} –\n'
      '${AppFormats.dateTime(contract.endAt)}',
      style: AppText.caption.copyWith(color: color),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  String _filterLabel(ContractFilter filter) {
    return switch (filter) {
      ContractFilter.all => AppStrings.filterAll,
      ContractFilter.attention => AppStrings.contractFilterAttention,
      ContractFilter.overdue => AppStrings.contractOverdue,
      ContractFilter.planned => AppStrings.contractStatusPlanned,
      ContractFilter.active => AppStrings.contractStatusActive,
      ContractFilter.completed => AppStrings.contractStatusCompleted,
      ContractFilter.cancelled => AppStrings.contractStatusCancelled,
    };
  }

  Color? _filterColor(ContractFilter filter) {
    return switch (filter) {
      ContractFilter.all => null,
      ContractFilter.attention => AppColors.warning,
      ContractFilter.overdue => AppColors.danger,
      ContractFilter.planned => AppColors.statusPlanned,
      ContractFilter.active => AppColors.statusRented,
      ContractFilter.completed => AppColors.statusAvailable,
      ContractFilter.cancelled => AppColors.statusBlocked,
    };
  }

  Future<void> _openForm(
    BuildContext context, {
    RentalContract? contract,
  }) async {
    final Object? saved = await showScopedDialog<Object>(
      context,
      (BuildContext context) => ContractFormDialog(
        contract: contract,
        customerId: widget.customerId,
        trailerId: widget.trailerId,
      ),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
  }

  Future<void> _handOver(BuildContext context, RentalContract contract) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool confirmed = await _confirm(
      context,
      AppStrings.contractHandOver,
      AppStrings.contractHandOverConfirm,
    );
    if (!confirmed || !context.mounted) {
      return;
    }
    await runAction(
      context,
      () => dependencies.contracts.handOver(
        contract.id,
        userId: dependencies.currentUserId,
      ),
      successMessage: AppStrings.contractHandedOver,
    );
  }

  Future<void> _return(BuildContext context, RentalContract contract) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool confirmed = await _confirm(
      context,
      AppStrings.contractReturn,
      AppStrings.contractReturnConfirm,
    );
    if (!confirmed || !context.mounted) {
      return;
    }
    await runAction(
      context,
      () => dependencies.contracts.completeReturn(
        contract.id,
        userId: dependencies.currentUserId,
      ),
      successMessage: AppStrings.contractReturned,
    );
  }

  Future<void> _cancel(BuildContext context, RentalContract contract) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const AppDialog(
        title: AppStrings.contractCancel,
        content: Text(AppStrings.contractCancelConfirm, style: AppText.body),
        confirmLabel: AppStrings.contractCancel,
        isDestructive: true,
      ),
    );
    if (confirmed != true || !context.mounted) {
      return;
    }
    await runAction(
      context,
      () => dependencies.contracts.cancel(contract.id),
      successMessage: AppStrings.contractCancelled,
    );
  }

  Future<bool> _confirm(
    BuildContext context,
    String title,
    String message,
  ) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AppDialog(
        title: title,
        content: Text(message, style: AppText.body),
        confirmLabel: title,
      ),
    );
    return confirmed ?? false;
  }
}

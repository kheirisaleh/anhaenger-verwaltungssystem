import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_data_table.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_icon_button.dart';
import '../../../core/design/widgets/app_select_field.dart';
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
      builder: (BuildContext context, Widget? child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: widget.shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: AppSelectField<ContractStatus?>(
                  label: AppStrings.fieldStatus,
                  value: controller.status,
                  placeholder: AppStrings.filterAll,
                  options: <AppSelectOption<ContractStatus?>>[
                    const AppSelectOption<ContractStatus?>(
                      value: null,
                      label: AppStrings.filterAll,
                    ),
                    for (final ContractStatus status in ContractStatus.values)
                      AppSelectOption<ContractStatus?>(
                        value: status,
                        label: status.label,
                      ),
                  ],
                  onChanged: controller.setStatus,
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
          if (widget.shrinkWrap)
            _buildList(context, controller)
          else
            Expanded(child: _buildList(context, controller)),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, ContractListController controller) {
    return LookupBuilder(
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
                  final List<RentalContract>? contracts = snapshot.data;
                  if (contracts == null) {
                    return const SizedBox(
                      height: 120,
                      child: AppLoadingState(),
                    );
                  }
                  if (contracts.isEmpty) {
                    return SizedBox(
                      height: 200,
                      child: AppEmptyState(
                        title: AppStrings.navContracts,
                        description: controller.hasFilter
                            ? AppStrings.emptySearch
                            : AppStrings.emptyContracts,
                        icon: AppIcons.contracts,
                      ),
                    );
                  }
                  return _buildTable(context, contracts, lookups);
                },
          ),
    );
  }

  Widget _buildTable(
    BuildContext context,
    List<RentalContract> contracts,
    Lookups lookups,
  ) {
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
        ),
        if (widget.customerId == null)
          AppDataColumn<RentalContract>(
            label: AppStrings.fieldCustomer,
            flex: 2,
            cellBuilder: (RentalContract c) =>
                AppTableText(lookups.customerName(c.customerId)),
          ),
        if (widget.trailerId == null)
          AppDataColumn<RentalContract>(
            label: AppStrings.fieldTrailer,
            flex: 2,
            cellBuilder: (RentalContract c) =>
                AppTableText(lookups.trailerName(c.trailerId)),
          ),
        AppDataColumn<RentalContract>(
          label: AppStrings.fieldPeriod,
          flex: 3,
          cellBuilder: (RentalContract c) => Text(
            '${AppFormats.dateTime(c.startAt)} –\n'
            '${AppFormats.dateTime(c.endAt)}',
            style: AppText.caption,
            maxLines: 2,
          ),
        ),
        AppDataColumn<RentalContract>(
          label: AppStrings.fieldPrice,
          isNumeric: true,
          cellBuilder: (RentalContract c) =>
              AppTableText(AppFormats.currencyFromCents(c.priceCents)),
        ),
        AppDataColumn<RentalContract>(
          label: AppStrings.fieldStatus,
          cellBuilder: (RentalContract c) => AppStatusBadge.contract(c.status),
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

  Future<void> _openForm(
    BuildContext context, {
    RentalContract? contract,
  }) async {
    final bool? saved = await showScopedDialog<bool>(
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

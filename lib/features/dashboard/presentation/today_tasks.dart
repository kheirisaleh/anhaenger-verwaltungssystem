import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_card.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/formatting/app_formats.dart';
import '../../../data/models/enums.dart';
import '../../../data/models/rental_contract.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/lookup_builder.dart';
import '../../../shared/run_action.dart';

class TodayTasks extends StatelessWidget {
  const TodayTasks({super.key, required this.contracts, required this.now});

  final List<RentalContract> contracts;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final List<RentalContract> tasks =
        contracts
            .where(
              (RentalContract c) => c.needsAttention(now) || c.isOverdue(now),
            )
            .toList()
          ..sort((RentalContract a, RentalContract b) {
            final DateTime aTime = a.status == ContractStatus.planned
                ? a.startAt
                : a.endAt;
            final DateTime bTime = b.status == ContractStatus.planned
                ? b.startAt
                : b.endAt;
            return aTime.compareTo(bTime);
          });
    return AppCard(
      title: '${AppStrings.dashboardToday} (${tasks.length})',
      child: tasks.isEmpty
          ? const Text(AppStrings.dashboardTodayEmpty, style: AppText.bodyMuted)
          : LookupBuilder(
              builder: (BuildContext context, Lookups lookups) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (final RentalContract contract in tasks)
                    _TaskRow(contract: contract, now: now, lookups: lookups),
                ],
              ),
            ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({
    required this.contract,
    required this.now,
    required this.lookups,
  });

  final RentalContract contract;
  final DateTime now;
  final Lookups lookups;

  bool get _isHandOver => contract.status == ContractStatus.planned;

  @override
  Widget build(BuildContext context) {
    final bool overdue = contract.isOverdue(now);
    final DateTime time = _isHandOver ? contract.startAt : contract.endAt;
    final String kind = _isHandOver
        ? AppStrings.contractHandOver
        : AppStrings.contractReturn;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: AppSpacing.xs,
            height: AppSizes.controlHeight,
            color: overdue ? AppColors.danger : AppColors.warning,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$kind · ${lookups.trailerName(contract.trailerId)}',
                  style: AppText.label,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${overdue ? '${AppStrings.contractOverdue} · ' : ''}'
                  '${AppFormats.dateTime(time)} · '
                  '${lookups.customerName(contract.customerId)}',
                  style: AppText.caption.copyWith(
                    color: overdue ? AppColors.danger : AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          AppButton(
            label: kind,
            icon: _isHandOver ? AppIcons.handOver : AppIcons.returnTrailer,
            variant: AppButtonVariant.primary,
            onPressed: () => _run(context),
          ),
        ],
      ),
    );
  }

  Future<void> _run(BuildContext context) async {
    final AppDependencies dependencies = AppScope.of(context);
    final String title = _isHandOver
        ? AppStrings.contractHandOver
        : AppStrings.contractReturn;
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AppDialog(
        title: title,
        content: Text(
          _isHandOver
              ? AppStrings.contractHandOverConfirm
              : AppStrings.contractReturnConfirm,
          style: AppText.body,
        ),
        confirmLabel: title,
      ),
    );
    if (confirmed != true || !context.mounted) {
      return;
    }
    await runAction(
      context,
      () => _isHandOver
          ? dependencies.contracts.handOver(
              contract.id,
              userId: dependencies.currentUserId,
            )
          : dependencies.contracts.completeReturn(
              contract.id,
              userId: dependencies.currentUserId,
            ),
      successMessage: _isHandOver
          ? AppStrings.contractHandedOver
          : AppStrings.contractReturned,
    );
  }
}

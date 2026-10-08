import 'package:fluent_ui/fluent_ui.dart';

import '../../../data/models/enums.dart';
import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppStatusBadge extends StatelessWidget {
  AppStatusBadge.trailer(TrailerStatus status, {super.key})
      : _text = status.label,
        _color = switch (status) {
          TrailerStatus.available => AppColors.statusAvailable,
          TrailerStatus.rented => AppColors.statusRented,
          TrailerStatus.maintenance => AppColors.statusMaintenance,
          TrailerStatus.blocked => AppColors.statusBlocked,
        };

  AppStatusBadge.contract(ContractStatus status, {super.key})
      : _text = status.label,
        _color = switch (status) {
          ContractStatus.planned => AppColors.statusPlanned,
          ContractStatus.active => AppColors.statusRented,
          ContractStatus.completed => AppColors.statusAvailable,
          ContractStatus.cancelled => AppColors.statusBlocked,
        };

  final String _text;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.badgeHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        _text,
        style: AppText.caption.copyWith(color: AppColors.textOnAccent),
      ),
    );
  }
}

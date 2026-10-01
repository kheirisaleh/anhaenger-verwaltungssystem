import 'package:fluent_ui/fluent_ui.dart';

import '../../../data/models/trailer_status.dart';
import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge.trailer(TrailerStatus status, {super.key})
      : _label = null,
        _trailerStatus = status,
        _contractStatus = null;

  const AppStatusBadge.contract(ContractStatus status, {super.key})
      : _label = null,
        _trailerStatus = null,
        _contractStatus = status;

  final String? _label;
  final TrailerStatus? _trailerStatus;
  final ContractStatus? _contractStatus;

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

  String get _text =>
      _label ?? _trailerStatus?.label ?? _contractStatus?.label ?? '';

  Color get _color {
    if (_trailerStatus != null) {
      return switch (_trailerStatus) {
        TrailerStatus.available => AppColors.statusAvailable,
        TrailerStatus.rented => AppColors.statusRented,
        TrailerStatus.maintenance => AppColors.statusMaintenance,
        TrailerStatus.blocked => AppColors.statusBlocked,
        null => AppColors.statusBlocked,
      };
    }
    return switch (_contractStatus) {
      ContractStatus.active => AppColors.statusRented,
      ContractStatus.completed => AppColors.statusAvailable,
      ContractStatus.cancelled => AppColors.statusBlocked,
      null => AppColors.statusBlocked,
    };
  }
}

import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

enum AppButtonVariant { primary, secondary, danger, subtle }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.secondary,
    this.icon,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null && !isLoading;
    return SizedBox(
      height: AppSizes.controlHeight,
      child: Button(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(_background),
          foregroundColor: WidgetStatePropertyAll<Color>(_foreground),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: AppSpacing.md),
          ),
          shape: WidgetStatePropertyAll<ShapeBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              side: BorderSide(color: _borderColor),
            ),
          ),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        width: AppSizes.iconSmall,
        height: AppSizes.iconSmall,
        child: ProgressRing(strokeWidth: 2, activeColor: _foreground),
      );
    }
    final Text text = Text(
      label,
      style: AppText.body.copyWith(color: _foreground),
    );
    if (icon == null) {
      return text;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: AppSizes.iconSmall, color: _foreground),
        const SizedBox(width: AppSpacing.sm),
        text,
      ],
    );
  }

  Color get _background => switch (variant) {
    AppButtonVariant.primary => AppColors.accent,
    AppButtonVariant.secondary => AppColors.surface,
    AppButtonVariant.danger => AppColors.danger,
    AppButtonVariant.subtle => const Color(0x00000000),
  };

  Color get _foreground => switch (variant) {
    AppButtonVariant.primary => AppColors.textOnAccent,
    AppButtonVariant.secondary => AppColors.textPrimary,
    AppButtonVariant.danger => AppColors.textOnAccent,
    AppButtonVariant.subtle => AppColors.accent,
  };

  Color get _borderColor => variant == AppButtonVariant.secondary
      ? AppColors.border
      : const Color(0x00000000);
}

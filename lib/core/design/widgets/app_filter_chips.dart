import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppFilterChip<T> {
  const AppFilterChip({
    required this.value,
    required this.label,
    this.count,
    this.color,
  });

  final T value;
  final String label;
  final int? count;
  final Color? color;
}

class AppFilterChips<T> extends StatelessWidget {
  const AppFilterChips({
    super.key,
    required this.chips,
    required this.selected,
    required this.onSelected,
  });

  final List<AppFilterChip<T>> chips;
  final T selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: <Widget>[
        for (final AppFilterChip<T> chip in chips)
          _Chip(
            label: chip.count == null
                ? chip.label
                : '${chip.label} (${chip.count})',
            color: chip.color,
            isSelected: chip.value == selected,
            onTap: () => onSelected(chip.value),
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.color,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color? dot = color;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSizes.controlHeight,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.controlHeight / 2),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (dot != null) ...<Widget>[
              Container(
                width: AppSpacing.sm,
                height: AppSpacing.sm,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.textOnAccent : dot,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(
              label,
              style: AppText.body.copyWith(
                color: isSelected ? AppColors.textOnAccent : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

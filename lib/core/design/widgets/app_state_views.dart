import 'package:fluent_ui/fluent_ui.dart';

import '../../constants/app_strings.dart';
import '../app_colors.dart';
import '../app_icons.dart';
import '../app_spacing.dart';
import '../app_typography.dart';
import 'app_button.dart';

class AppLoadingState extends StatelessWidget {
  const AppLoadingState({super.key, this.message = AppStrings.loading});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ProgressRing(),
          const SizedBox(height: AppSpacing.md),
          Text(message, style: AppText.bodyMuted),
        ],
      ),
    );
  }
}

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon = AppIcons.trailers,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? description;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: AppSizes.iconState, color: AppColors.textDisabled),
          const SizedBox(height: AppSpacing.md),
          Text(title, style: AppText.cardTitle),
          if (description != null) ...<Widget>[
            const SizedBox(height: AppSpacing.xs),
            Text(description!, style: AppText.bodyMuted),
          ],
          if (actionLabel != null) ...<Widget>[
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: actionLabel!,
              variant: AppButtonVariant.primary,
              icon: AppIcons.add,
              onPressed: onAction,
            ),
          ],
        ],
      ),
    );
  }
}

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    this.message = AppStrings.errorGeneric,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            AppIcons.error,
            size: AppSizes.iconState,
            color: AppColors.danger,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(AppStrings.errorGeneric, style: AppText.cardTitle),
          const SizedBox(height: AppSpacing.xs),
          Text(message, style: AppText.bodyMuted),
          if (onRetry != null) ...<Widget>[
            const SizedBox(height: AppSpacing.md),
            AppButton(label: AppStrings.actionRetry, onPressed: onRetry),
          ],
        ],
      ),
    );
  }
}

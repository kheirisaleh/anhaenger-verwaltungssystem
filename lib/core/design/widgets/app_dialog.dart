import 'package:fluent_ui/fluent_ui.dart';

import '../../constants/app_strings.dart';
import '../app_spacing.dart';
import '../app_typography.dart';
import 'app_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmLabel = AppStrings.actionConfirm,
    this.onConfirm,
    this.isDestructive = false,
    this.isLarge = false,
    this.isLoading = false,
  });

  final String title;
  final Widget content;
  final String confirmLabel;
  final VoidCallback? onConfirm;
  final bool isDestructive;
  final bool isLarge;
  final bool isLoading;

  static Future<bool> confirmDelete(
    BuildContext context, {
    String message = AppStrings.confirmDelete,
  }) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => AppDialog(
        title: AppStrings.actionDelete,
        content: Text(message, style: AppText.body),
        confirmLabel: AppStrings.actionDelete,
        isDestructive: true,
      ),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final double width =
        isLarge ? AppSizes.dialogWidthLarge : AppSizes.dialogWidth;
    return ContentDialog(
      constraints: BoxConstraints(maxWidth: width),
      title: Text(title, style: AppText.sectionTitle),
      content: content,
      actions: <Widget>[
        AppButton(
          label: AppStrings.actionCancel,
          onPressed: isLoading ? null : () => Navigator.of(context).pop(false),
        ),
        AppButton(
          label: confirmLabel,
          variant: isDestructive
              ? AppButtonVariant.danger
              : AppButtonVariant.primary,
          isLoading: isLoading,
          onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}

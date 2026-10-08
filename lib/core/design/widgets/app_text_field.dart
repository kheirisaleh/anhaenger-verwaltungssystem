import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.placeholder,
    this.errorText,
    this.isRequired = false,
    this.maxLines = 1,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final String? placeholder;
  final String? errorText;
  final bool isRequired;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorText != null && errorText!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(isRequired ? '$label *' : label, style: AppText.label),
        const SizedBox(height: AppSpacing.xs),
        TextBox(
          controller: controller,
          placeholder: placeholder,
          maxLines: maxLines,
          onChanged: onChanged,
          style: AppText.body,
          decoration: WidgetStatePropertyAll<BoxDecoration>(
            BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(
                color: hasError ? AppColors.danger : AppColors.border,
              ),
            ),
          ),
        ),
        if (hasError) ...<Widget>[
          const SizedBox(height: AppSpacing.xs),
          Text(
            errorText!,
            style: AppText.caption.copyWith(color: AppColors.danger),
          ),
        ],
      ],
    );
  }
}

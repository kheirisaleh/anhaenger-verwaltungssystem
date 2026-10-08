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
    this.helperText,
    this.isRequired = false,
    this.maxLines = 1,
    this.autofocus = false,
    this.suffixText,
    this.onChanged,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController? controller;
  final String? placeholder;
  final String? errorText;
  final String? helperText;
  final bool isRequired;
  final int maxLines;
  final bool autofocus;
  final String? suffixText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final String? error = errorText;
    final String? helper = helperText;
    final String? suffix = suffixText;
    final bool hasError = error != null && error.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(isRequired ? '$label *' : label, style: AppText.label),
        const SizedBox(height: AppSpacing.xs),
        TextBox(
          controller: controller,
          placeholder: placeholder,
          maxLines: maxLines,
          autofocus: autofocus,
          onChanged: onChanged,
          onSubmitted: maxLines == 1 ? onSubmitted : null,
          style: AppText.body,
          suffix: suffix == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Text(suffix, style: AppText.bodyMuted),
                ),
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
        if (error != null && error.isNotEmpty) ...<Widget>[
          const SizedBox(height: AppSpacing.xs),
          Text(error, style: AppText.caption.copyWith(color: AppColors.danger)),
        ] else if (helper != null) ...<Widget>[
          const SizedBox(height: AppSpacing.xs),
          Text(helper, style: AppText.caption),
        ],
      ],
    );
  }
}

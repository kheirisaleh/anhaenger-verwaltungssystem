import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppSelectOption<T> {
  const AppSelectOption({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  final T value;
  final String label;
  final bool enabled;
}

class AppSelectField<T> extends StatelessWidget {
  const AppSelectField({
    super.key,
    required this.label,
    required this.options,
    this.value,
    this.onChanged,
    this.placeholder,
    this.errorText,
    this.helperText,
    this.isRequired = false,
    this.action,
  });

  final String label;
  final List<AppSelectOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;
  final String? errorText;
  final String? helperText;
  final bool isRequired;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final String? error = errorText;
    final String? helper = helperText;
    final String? hint = placeholder;
    final Widget? trailing = action;
    final Widget comboBox = SizedBox(
      width: double.infinity,
      child: ComboBox<T>(
        isExpanded: true,
        value: value,
        onChanged: onChanged,
        placeholder: hint == null ? null : Text(hint, style: AppText.bodyMuted),
        items: <ComboBoxItem<T>>[
          for (final AppSelectOption<T> option in options)
            ComboBoxItem<T>(
              value: option.value,
              enabled: option.enabled,
              child: Text(
                option.label,
                style: option.enabled ? AppText.body : AppText.bodyMuted,
              ),
            ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(isRequired ? '$label *' : label, style: AppText.label),
        const SizedBox(height: AppSpacing.xs),
        if (trailing == null)
          comboBox
        else
          Row(
            children: <Widget>[
              Expanded(child: comboBox),
              const SizedBox(width: AppSpacing.sm),
              trailing,
            ],
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

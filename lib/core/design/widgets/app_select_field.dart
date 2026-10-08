import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppSelectOption<T> {
  const AppSelectOption({required this.value, required this.label});

  final T value;
  final String label;
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
    this.isRequired = false,
  });

  final String label;
  final List<AppSelectOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;
  final String? errorText;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final String? error = errorText;
    final String? hint = placeholder;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(isRequired ? '$label *' : label, style: AppText.label),
        const SizedBox(height: AppSpacing.xs),
        SizedBox(
          height: AppSizes.controlHeight,
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
                  child: Text(option.label, style: AppText.body),
                ),
            ],
          ),
        ),
        if (error != null && error.isNotEmpty) ...<Widget>[
          const SizedBox(height: AppSpacing.xs),
          Text(error, style: AppText.caption.copyWith(color: AppColors.danger)),
        ],
      ],
    );
  }
}

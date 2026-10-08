import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppDateTimeField extends StatelessWidget {
  const AppDateTimeField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.showTime = true,
    this.isRequired = false,
    this.errorText,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;
  final bool showTime;
  final bool isRequired;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final String? error = errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(isRequired ? '$label *' : label, style: AppText.label),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: DatePicker(
                selected: value,
                startDate: DateTime(2000),
                endDate: DateTime(2100),
                onChanged: (DateTime date) => onChanged(
                  DateTime(
                    date.year,
                    date.month,
                    date.day,
                    value.hour,
                    value.minute,
                  ),
                ),
              ),
            ),
            if (showTime) ...<Widget>[
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 2,
                child: TimePicker(
                  selected: value,
                  hourFormat: HourFormat.HH,
                  onChanged: (DateTime time) => onChanged(
                    DateTime(
                      value.year,
                      value.month,
                      value.day,
                      time.hour,
                      time.minute,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        if (error != null && error.isNotEmpty) ...<Widget>[
          const SizedBox(height: AppSpacing.xs),
          Text(error, style: AppText.caption.copyWith(color: AppColors.danger)),
        ],
      ],
    );
  }
}

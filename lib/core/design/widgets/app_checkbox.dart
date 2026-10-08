import 'package:fluent_ui/fluent_ui.dart';

import '../app_typography.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checked: value,
      onChanged: (bool? checked) => onChanged(checked ?? false),
      content: Text(label, style: AppText.body),
    );
  }
}

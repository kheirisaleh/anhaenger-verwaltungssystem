import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_icons.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    required this.placeholder,
    required this.onChanged,
  });

  final String placeholder;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.controlHeight,
      child: TextBox(
        placeholder: placeholder,
        onChanged: onChanged,
        style: AppText.body,
        prefix: const Padding(
          padding: EdgeInsets.only(left: AppSpacing.sm),
          child: Icon(
            AppIcons.search,
            size: AppSizes.iconSmall,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

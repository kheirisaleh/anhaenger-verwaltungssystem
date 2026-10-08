import 'package:fluent_ui/fluent_ui.dart';

import '../../constants/app_strings.dart';
import '../app_colors.dart';
import '../app_icons.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    required this.placeholder,
    required this.onChanged,
  });

  final String placeholder;
  final ValueChanged<String> onChanged;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextBox(
      controller: _controller,
      placeholder: widget.placeholder,
      style: AppText.body,
      onChanged: (String value) {
        widget.onChanged(value);
        setState(() {});
      },
      prefix: const Padding(
        padding: EdgeInsets.only(left: AppSpacing.sm),
        child: Icon(
          AppIcons.search,
          size: AppSizes.iconSmall,
          color: AppColors.textSecondary,
        ),
      ),
      suffix: _controller.text.isEmpty
          ? null
          : Tooltip(
              message: AppStrings.actionClearSearch,
              child: IconButton(
                icon: const Icon(AppIcons.clear, size: AppSizes.iconTiny),
                onPressed: _clear,
              ),
            ),
    );
  }
}

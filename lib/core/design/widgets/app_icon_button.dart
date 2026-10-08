import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_spacing.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.isDestructive = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(
          icon,
          size: AppSizes.iconSmall,
          color: isDestructive ? AppColors.danger : AppColors.textPrimary,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

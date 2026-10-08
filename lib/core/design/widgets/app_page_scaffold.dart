import 'package:fluent_ui/fluent_ui.dart';

import '../../constants/app_strings.dart';
import '../app_colors.dart';
import '../app_icons.dart';
import '../app_spacing.dart';
import '../app_typography.dart';
import 'app_icon_button.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({
    super.key,
    required this.title,
    required this.content,
    this.actions = const <Widget>[],
    this.filterBar,
    this.onBack,
  });

  final String title;
  final Widget content;
  final List<Widget> actions;
  final Widget? filterBar;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final Widget? filter = filterBar;
    final VoidCallback? back = onBack;
    return ColoredBox(
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                if (back != null) ...<Widget>[
                  AppIconButton(
                    icon: AppIcons.back,
                    tooltip: AppStrings.actionBack,
                    onPressed: back,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: AppText.pageTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                for (final Widget action in actions) ...<Widget>[
                  const SizedBox(width: AppSpacing.sm),
                  action,
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            if (filter != null) ...<Widget>[
              filter,
              const SizedBox(height: AppSpacing.md),
            ],
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}

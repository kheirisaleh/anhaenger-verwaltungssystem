import 'package:fluent_ui/fluent_ui.dart';

import '../app_spacing.dart';
import '../app_typography.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({
    super.key,
    required this.title,
    required this.content,
    this.actions = const <Widget>[],
    this.filterBar,
  });

  final String title;
  final Widget content;
  final List<Widget> actions;
  final Widget? filterBar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(title, style: AppText.pageTitle)),
              for (final Widget action in actions) ...<Widget>[
                const SizedBox(width: AppSpacing.sm),
                action,
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (filterBar != null) ...<Widget>[
            filterBar!,
            const SizedBox(height: AppSpacing.md),
          ],
          Expanded(child: content),
        ],
      ),
    );
  }
}

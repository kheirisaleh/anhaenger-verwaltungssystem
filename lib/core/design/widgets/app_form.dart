import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppForm extends StatelessWidget {
  const AppForm({super.key, required this.children, this.errorMessage});

  final List<Widget> children;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final String? error = errorMessage;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (error != null) ...<Widget>[
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.danger),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text(
                error,
                style: AppText.body.copyWith(color: AppColors.danger),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          for (int i = 0; i < children.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(height: AppSpacing.md),
            children[i],
          ],
        ],
      ),
    );
  }
}

class AppFormRow extends StatelessWidget {
  const AppFormRow({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < children.length; i++) ...<Widget>[
          if (i > 0) const SizedBox(width: AppSpacing.md),
          Expanded(child: children[i]),
        ],
      ],
    );
  }
}

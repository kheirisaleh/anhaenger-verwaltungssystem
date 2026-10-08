import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import '../../../core/design/widgets/app_state_views.dart';

class DamagesPage extends StatelessWidget {
  const DamagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPageScaffold(
      title: AppStrings.navDamages,
      content: AppEmptyState(
        title: AppStrings.navDamages,
        description: AppStrings.emptyDamagesOverview,
        icon: AppIcons.damages,
      ),
    );
  }
}

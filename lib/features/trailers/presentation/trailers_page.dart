import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import '../../../core/design/widgets/app_state_views.dart';

class TrailersPage extends StatelessWidget {
  const TrailersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPageScaffold(
      title: AppStrings.navTrailers,
      content: AppEmptyState(
        title: AppStrings.navTrailers,
        description: AppStrings.emptyTrailers,
        icon: AppIcons.trailers,
      ),
    );
  }
}

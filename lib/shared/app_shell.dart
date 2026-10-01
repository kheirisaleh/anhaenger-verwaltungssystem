import 'package:fluent_ui/fluent_ui.dart';

import '../core/constants/app_strings.dart';
import '../core/design/app_icons.dart';
import '../core/design/app_spacing.dart';
import '../core/design/widgets/app_page_scaffold.dart';
import '../core/design/widgets/app_state_views.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: (int index) => setState(() => _selectedIndex = index),
        displayMode: PaneDisplayMode.expanded,
        size: const NavigationPaneSize(openWidth: AppSizes.navigationPaneWidth),
        items: <NavigationPaneItem>[
          _item(AppIcons.dashboard, AppStrings.navDashboard),
          _item(AppIcons.trailers, AppStrings.navTrailers),
          _item(AppIcons.damages, AppStrings.navDamages),
          _item(AppIcons.customers, AppStrings.navCustomers),
          _item(AppIcons.contracts, AppStrings.navContracts),
        ],
        footerItems: <NavigationPaneItem>[
          _item(AppIcons.settings, AppStrings.navSettings),
        ],
      ),
    );
  }

  NavigationPaneItem _item(IconData icon, String title) {
    return PaneItem(
      icon: Icon(icon, size: AppSizes.iconNavigation),
      title: Text(title),
      body: AppPageScaffold(
        title: title,
        content: AppEmptyState(
          title: title,
          description: AppStrings.emptyTrailers,
          icon: icon,
        ),
      ),
    );
  }
}

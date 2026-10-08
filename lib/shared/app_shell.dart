import 'package:fluent_ui/fluent_ui.dart';

import '../core/constants/app_strings.dart';
import '../core/design/app_icons.dart';
import '../core/design/app_spacing.dart';
import '../data/models/app_user.dart';
import '../data/models/rental_contract.dart';
import '../features/contracts/presentation/contracts_page.dart';
import '../features/customers/presentation/customers_page.dart';
import '../features/damages/presentation/damages_page.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../features/trailers/presentation/trailers_page.dart';
import 'app_dependencies.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.user, required this.onSwitchUser});

  final AppUser user;
  final VoidCallback onSwitchUser;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  Stream<List<RentalContract>>? _contracts;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contracts ??= AppScope.of(context).contracts.watchAll();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RentalContract>>(
      stream: _contracts,
      builder:
          (BuildContext context, AsyncSnapshot<List<RentalContract>> snapshot) {
            final DateTime now = DateTime.now();
            final int attention =
                (snapshot.data ?? const <RentalContract>[])
                    .where(
                      (RentalContract c) =>
                          c.needsAttention(now) || c.isOverdue(now),
                    )
                    .length;
            return _buildNavigation(attention);
          },
    );
  }

  Widget _buildNavigation(int attention) {
    return NavigationView(
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: (int index) => setState(() => _selectedIndex = index),
        displayMode: PaneDisplayMode.auto,
        size: const NavigationPaneSize(openWidth: AppSizes.navigationPaneWidth),
        items: <NavigationPaneItem>[
          _item(
            AppIcons.dashboard,
            AppStrings.navDashboard,
            const DashboardPage(),
            badge: attention,
          ),
          _item(AppIcons.trailers, AppStrings.navTrailers, const TrailersPage()),
          _item(AppIcons.damages, AppStrings.navDamages, const DamagesPage()),
          _item(
            AppIcons.customers,
            AppStrings.navCustomers,
            const CustomersPage(),
          ),
          _item(
            AppIcons.contracts,
            AppStrings.navContracts,
            const ContractsPage(),
            badge: attention,
          ),
        ],
        footerItems: <NavigationPaneItem>[
          _item(AppIcons.settings, AppStrings.navSettings, const SettingsPage()),
          PaneItemAction(
            icon: const Icon(AppIcons.user, size: AppSizes.iconNavigation),
            title: Text('${AppStrings.currentUser} ${widget.user.name}'),
            onTap: widget.onSwitchUser,
          ),
        ],
      ),
    );
  }

  PaneItem _item(IconData icon, String title, Widget body, {int badge = 0}) {
    return PaneItem(
      icon: Icon(icon, size: AppSizes.iconNavigation),
      title: Text(title),
      infoBadge: badge > 0
          ? InfoBadge(
              source: Text('$badge'),
              severity: InfoBarSeverity.warning,
            )
          : null,
      body: body,
    );
  }
}

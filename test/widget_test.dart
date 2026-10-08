import 'dart:io';

import 'package:anhaenger_verwaltungssystem/core/constants/app_strings.dart';
import 'package:anhaenger_verwaltungssystem/core/database/app_database.dart';
import 'package:anhaenger_verwaltungssystem/core/database/app_directories.dart';
import 'package:anhaenger_verwaltungssystem/core/design/app_theme.dart';
import 'package:anhaenger_verwaltungssystem/core/design/widgets/app_status_badge.dart';
import 'package:anhaenger_verwaltungssystem/data/models/app_user.dart';
import 'package:anhaenger_verwaltungssystem/data/models/enums.dart';
import 'package:anhaenger_verwaltungssystem/shared/app_dependencies.dart';
import 'package:anhaenger_verwaltungssystem/shared/app_root.dart';
import 'package:anhaenger_verwaltungssystem/shared/app_shell.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_database.dart';

Widget wrap(Widget child) {
  return FluentApp(theme: AppTheme.build(), home: child);
}

void main() {
  testWidgets('Navigation zeigt alle Bereiche und den Benutzer', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        AppShell(
          user: const AppUser(id: 1, name: 'Anna', isActive: true),
          onSwitchUser: () {},
        ),
      ),
    );

    for (final String label in <String>[
      AppStrings.navDashboard,
      AppStrings.navTrailers,
      AppStrings.navDamages,
      AppStrings.navCustomers,
      AppStrings.navContracts,
      AppStrings.navSettings,
    ]) {
      expect(find.text(label), findsWidgets);
    }
    expect(find.text('${AppStrings.currentUser} Anna'), findsOneWidget);
  });

  testWidgets('Status-Badges zeigen die deutschen Bezeichnungen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        Column(
          children: <Widget>[
            for (final TrailerStatus status in TrailerStatus.values)
              AppStatusBadge.trailer(status),
            for (final ContractStatus status in ContractStatus.values)
              AppStatusBadge.contract(status),
          ],
        ),
      ),
    );

    expect(find.text(AppStrings.statusAvailable), findsOneWidget);
    expect(find.text(AppStrings.contractStatusPlanned), findsOneWidget);
  });

  testWidgets('Start zeigt die Benutzerauswahl', (WidgetTester tester) async {
    final AppDependencies dependencies = AppDependencies.create(
      createTestDatabase(),
      AppDirectories(Directory.systemTemp),
    );

    await tester.pumpWidget(
      wrap(AppRoot(openDependencies: () async => dependencies)),
    );
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    expect(find.text('${AppStrings.startupSelectUser} *'), findsOneWidget);
    expect(find.text(AppStrings.actionStart), findsOneWidget);

    dependencies.currentUser.value = const AppUser(
      id: 1,
      name: AppDatabase.defaultUserName,
      isActive: true,
    );
    await tester.pump();

    expect(find.text(AppStrings.navTrailers), findsWidgets);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });
}

import 'dart:io';

import 'package:anhaenger_verwaltungssystem/core/constants/app_strings.dart';
import 'package:anhaenger_verwaltungssystem/core/database/app_database.dart';
import 'package:anhaenger_verwaltungssystem/core/database/app_directories.dart';
import 'package:anhaenger_verwaltungssystem/core/design/app_theme.dart';
import 'package:anhaenger_verwaltungssystem/core/design/widgets/app_status_badge.dart';
import 'package:anhaenger_verwaltungssystem/core/formatting/app_formats.dart';
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

AppDependencies createDependencies() {
  return AppDependencies.create(
    createTestDatabase(),
    AppDirectories(Directory.systemTemp),
  );
}

void useDesktopSize(WidgetTester tester) {
  tester.view.physicalSize = const Size(1400, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> pumpFrames(WidgetTester tester) async {
  for (int i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

void main() {
  setUpAll(AppFormats.initialize);

  testWidgets('Navigation zeigt alle Bereiche und den Benutzer', (
    WidgetTester tester,
  ) async {
    useDesktopSize(tester);
    final AppDependencies dependencies = createDependencies();

    await tester.pumpWidget(
      wrap(
        AppScope(
          dependencies: dependencies,
          child: AppShell(
            user: const AppUser(id: 1, name: 'Anna', isActive: true),
            onSwitchUser: () {},
          ),
        ),
      ),
    );
    await pumpFrames(tester);

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

    await tester.pumpWidget(const SizedBox());
    await tester.runAsync(() => dependencies.dispose());
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
    useDesktopSize(tester);
    final AppDependencies dependencies = createDependencies();

    await tester.pumpWidget(
      wrap(AppRoot(openDependencies: () async => dependencies)),
    );
    await pumpFrames(tester);

    expect(find.text('${AppStrings.startupSelectUser} *'), findsOneWidget);
    expect(find.text(AppStrings.actionStart), findsOneWidget);

    dependencies.currentUser.value = const AppUser(
      id: 1,
      name: AppDatabase.defaultUserName,
      isActive: true,
    );
    await pumpFrames(tester);

    expect(find.text(AppStrings.navTrailers), findsWidgets);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });
}

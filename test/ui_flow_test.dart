import 'dart:io';

import 'package:anhaenger_verwaltungssystem/core/constants/app_strings.dart';
import 'package:anhaenger_verwaltungssystem/core/database/app_directories.dart';
import 'package:anhaenger_verwaltungssystem/core/design/app_theme.dart';
import 'package:anhaenger_verwaltungssystem/core/formatting/app_formats.dart';
import 'package:anhaenger_verwaltungssystem/data/models/app_user.dart';
import 'package:anhaenger_verwaltungssystem/shared/app_dependencies.dart';
import 'package:anhaenger_verwaltungssystem/shared/app_shell.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_database.dart';

Future<void> settle(WidgetTester tester) async {
  for (int i = 0; i < 12; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> openPane(WidgetTester tester, String label) async {
  await tester.tap(find.text(label).first);
  await settle(tester);
}

Future<void> openAndCancelDialog(
  WidgetTester tester,
  String buttonLabel,
) async {
  await tester.tap(find.text(buttonLabel).first);
  await settle(tester);
  expect(find.text(AppStrings.actionCancel), findsWidgets);
  await tester.tap(find.text(AppStrings.actionCancel).last);
  await settle(tester);
}

void main() {
  setUpAll(AppFormats.initialize);

  testWidgets('Alle Bereiche lassen sich mit Beispieldaten bedienen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final AppDependencies dependencies = AppDependencies.create(
      createTestDatabase(),
      AppDirectories(Directory.systemTemp),
    );
    await tester.runAsync(() => dependencies.sampleData().seed());
    const AppUser user = AppUser(id: 1, name: 'Administrator', isActive: true);
    dependencies.currentUser.value = user;

    await tester.pumpWidget(
      FluentApp(
        theme: AppTheme.build(),
        home: AppScope(
          dependencies: dependencies,
          child: AppShell(user: user, onSwitchUser: () {}),
        ),
      ),
    );
    await settle(tester);

    expect(find.text(AppStrings.dashboardFleet), findsOneWidget);
    expect(find.text(AppStrings.dashboardRentalsPerMonth), findsOneWidget);

    await openPane(tester, AppStrings.navTrailers);
    expect(find.text('BLITZ-01'), findsOneWidget);
    expect(find.text('MAMMUT-08'), findsOneWidget);
    await openAndCancelDialog(tester, AppStrings.trailerCreate);

    await tester.tap(find.text(AppStrings.fieldLicensePlate));
    await settle(tester);
    await tester.tap(find.textContaining('${AppStrings.statusRented} ('));
    await settle(tester);
    expect(find.text('BLITZ-01'), findsOneWidget);
    expect(find.text('OMA-03'), findsNothing);
    await tester.tap(find.textContaining('${AppStrings.filterAll} ('));
    await settle(tester);
    expect(find.text('OMA-03'), findsOneWidget);

    await tester.tap(find.text('BLITZ-01'));
    await settle(tester);
    expect(find.textContaining('BLITZ-01 ·'), findsOneWidget);
    expect(find.text(AppStrings.sectionDamageHistory), findsOneWidget);
    expect(find.text(AppStrings.sectionStatusHistory), findsOneWidget);
    await openAndCancelDialog(tester, AppStrings.trailerChangeLocation);
    expect(find.text(AppStrings.trailerRentedHint), findsOneWidget);
    await openAndCancelDialog(tester, AppStrings.trailerRent);
    Navigator.of(
      tester.element(find.text(AppStrings.sectionStatusHistory)),
    ).pop();
    await settle(tester);

    await openPane(tester, AppStrings.navDamages);
    expect(find.textContaining('Gartenzwerg'), findsOneWidget);
    await openAndCancelDialog(tester, AppStrings.damageCreate);

    await openPane(tester, AppStrings.navCustomers);
    expect(find.text('Rainer Zufall'), findsOneWidget);
    await openAndCancelDialog(tester, AppStrings.customerCreate);
    await tester.tap(find.text('Rainer Zufall'));
    await settle(tester);
    expect(find.text(AppStrings.sectionContactData), findsOneWidget);
    Navigator.of(
      tester.element(find.text(AppStrings.sectionContactData)),
    ).pop();
    await settle(tester);

    await openPane(tester, AppStrings.navContracts);
    expect(find.text(AppStrings.contractStatusPlanned), findsWidgets);
    expect(find.text(AppStrings.contractStatusActive), findsWidgets);
    await tester.tap(
      find.textContaining('${AppStrings.contractStatusPlanned} ('),
    );
    await settle(tester);
    expect(find.text(AppStrings.contractStatusActive), findsNothing);
    await tester.tap(find.text(AppStrings.contractCreate).first);
    await settle(tester);
    await tester.tap(find.text(AppStrings.actionNew).first);
    await settle(tester);
    expect(find.text('${AppStrings.fieldFirstName} *'), findsOneWidget);
    await tester.tap(find.text(AppStrings.actionCancel).last);
    await settle(tester);
    expect(find.text('${AppStrings.fieldFirstName} *'), findsNothing);
    await tester.tap(find.text(AppStrings.actionCancel).last);
    await settle(tester);

    await openPane(tester, AppStrings.navSettings);
    expect(find.text(AppStrings.settingsUsers), findsOneWidget);
    expect(find.text('Kalle Kupplung'), findsOneWidget);
    expect(find.text(AppStrings.backupExport), findsOneWidget);
    await openAndCancelDialog(tester, AppStrings.trailerTypeCreate);

    await tester.pumpWidget(const SizedBox());
    await tester.runAsync(() => dependencies.dispose());
  });
}

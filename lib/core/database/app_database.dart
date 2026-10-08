import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../data/models/enums.dart';
import 'app_directories.dart';
import 'tables.dart';

export 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: <Type>[
    AppUsers,
    TrailerTypes,
    Trailers,
    TrailerStatusChanges,
    Customers,
    RentalContracts,
    DamageRecords,
    Photos,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.open(AppDirectories directories)
    : super(_openConnection(directories));

  static const String defaultUserName = 'Administrator';

  static const List<String> defaultTrailerTypes = <String>[
    'Pkw-Anhänger',
    'Kastenanhänger',
    'Planenanhänger',
    'Tieflader',
    'Autotransporter',
  ];

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator migrator) async {
      await migrator.createAll();
      await _insertDefaults();
    },
    beforeOpen: (OpeningDetails details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> _insertDefaults() async {
    await into(appUsers).insert(
      AppUsersCompanion.insert(name: defaultUserName),
    );
    await batch((Batch operations) {
      operations.insertAll(
        trailerTypes,
        <TrailerTypesCompanion>[
          for (final String name in defaultTrailerTypes)
            TrailerTypesCompanion.insert(name: name),
        ],
      );
    });
  }

  static QueryExecutor _openConnection(AppDirectories directories) {
    return driftDatabase(
      name: 'app',
      native: DriftNativeOptions(
        databasePath: () async {
          final File file = directories.databaseFile;
          await file.parent.create(recursive: true);
          return file.path;
        },
      ),
    );
  }
}

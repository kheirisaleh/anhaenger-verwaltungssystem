import 'dart:io';

import 'package:anhaenger_verwaltungssystem/core/database/app_database.dart';
import 'package:anhaenger_verwaltungssystem/core/database/app_directories.dart';
import 'package:anhaenger_verwaltungssystem/data/models/customer.dart';
import 'package:anhaenger_verwaltungssystem/data/models/damage_record.dart';
import 'package:anhaenger_verwaltungssystem/data/models/enums.dart';
import 'package:anhaenger_verwaltungssystem/data/models/rental_contract.dart';
import 'package:anhaenger_verwaltungssystem/data/models/trailer.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/trailer_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/sources/backup_service.dart';
import 'package:anhaenger_verwaltungssystem/data/sources/sample_data_seeder.dart';
import 'package:anhaenger_verwaltungssystem/shared/app_dependencies.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late Directory root;
  late AppDependencies dependencies;

  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  setUp(() async {
    root = await Directory.systemTemp.createTemp('anhaenger_seed_');
    dependencies = AppDependencies.create(
      createTestDatabase(),
      AppDirectories(root),
    );
  });

  tearDown(() async {
    await dependencies.dispose();
    await root.delete(recursive: true);
  });

  test('Beispieldaten werden vollstaendig und regelkonform geladen', () async {
    final SampleDataSeeder seeder = dependencies.sampleData();

    expect(await seeder.seedIfEmpty(), isTrue);
    expect(await seeder.seedIfEmpty(), isFalse);

    final List<Trailer> trailers = await dependencies.trailers.watchAll().first;
    final List<Customer> customers = await dependencies.customers
        .watchAll()
        .first;
    final List<RentalContract> contracts = await dependencies.contracts
        .watchAll()
        .first;
    final List<DamageRecord> damages = await dependencies.damages
        .watchAll()
        .first;

    expect(trailers, hasLength(8));
    expect(customers, hasLength(8));
    expect(damages, hasLength(6));
    expect(
      contracts.where(
        (RentalContract c) => c.status == ContractStatus.completed,
      ),
      isNotEmpty,
    );
    expect(
      contracts.where((RentalContract c) => c.status == ContractStatus.active),
      hasLength(2),
    );
    expect(
      contracts.where((RentalContract c) => c.status == ContractStatus.planned),
      hasLength(3),
    );
    expect(
      contracts.where(
        (RentalContract c) => c.status == ContractStatus.cancelled,
      ),
      hasLength(1),
    );

    TrailerStatus statusOf(String code) =>
        trailers.firstWhere((Trailer t) => t.internalCode == code).status;
    expect(statusOf('BLITZ-01'), TrailerStatus.rented);
    expect(statusOf('PIRAT-07'), TrailerStatus.rented);
    expect(statusOf('SCHNECKE-02'), TrailerStatus.maintenance);
    expect(statusOf('ROSTI-06'), TrailerStatus.blocked);
    expect(statusOf('OMA-03'), TrailerStatus.available);
  });

  test('Damage-Filter nach Anhaenger', () async {
    await dependencies.sampleData().seed();
    final List<Trailer> trailers = await dependencies.trailers.watchAll().first;
    final int blitz = trailers
        .firstWhere((Trailer t) => t.internalCode == 'BLITZ-01')
        .id;

    final List<DamageRecord> damages = await dependencies.damages
        .watchAll(filter: DamageFilter(trailerId: blitz))
        .first;

    expect(damages, hasLength(1));
    expect(damages.single.causedBy, DamageCause.customer);
  });

  test('Archivieren und Wiederherstellen', () async {
    final Trailer trailer = await createTestTrailer(dependencies.database);
    final Customer customer = await createTestCustomer(dependencies.database);

    await dependencies.trailers.archive(trailer.id);
    await dependencies.customers.archive(customer.id);
    expect(await dependencies.trailers.watchAll().first, isEmpty);
    expect(await dependencies.customers.watchAll().first, isEmpty);

    await dependencies.trailers.restore(trailer.id);
    await dependencies.customers.restore(customer.id);
    expect(await dependencies.trailers.watchAll().first, hasLength(1));
    expect(await dependencies.customers.watchAll().first, hasLength(1));
  });

  test('Sicherung erstellen und einspielen', () async {
    await dependencies.sampleData().seed();
    final Directory images = dependencies.directories.imagesDirectory;
    await File('${images.path}/trailers/1/foto.jpg').create(recursive: true);
    final Directory exportParent = await Directory(
      '${root.path}/exports',
    ).create();

    final Directory backup = await dependencies.backup.export(exportParent);

    expect(BackupService.isBackupFolder(backup), isTrue);
    expect(
      File('${backup.path}/images/trailers/1/foto.jpg').existsSync(),
      isTrue,
    );

    final AppDirectories target = AppDirectories(
      await Directory('${root.path}/restored').create(),
    );
    await BackupService.restoreFiles(backup, target);

    expect(
      File('${target.imagesDirectory.path}/trailers/1/foto.jpg').existsSync(),
      isTrue,
    );
    final AppDatabase restored = AppDatabase(
      NativeDatabase(target.databaseFile),
    );
    final AppDependencies restoredDependencies = AppDependencies.create(
      restored,
      target,
    );
    final List<Trailer> trailers = await restoredDependencies.trailers
        .watchAll(query: const TrailerQuery(includeArchived: true))
        .first;
    expect(trailers, hasLength(8));
    await restoredDependencies.dispose();
  });
}

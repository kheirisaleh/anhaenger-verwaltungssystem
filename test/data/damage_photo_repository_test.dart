import 'dart:io';

import 'package:anhaenger_verwaltungssystem/core/database/app_database.dart';
import 'package:anhaenger_verwaltungssystem/core/database/app_directories.dart';
import 'package:anhaenger_verwaltungssystem/data/models/damage_record.dart';
import 'package:anhaenger_verwaltungssystem/data/models/enums.dart';
import 'package:anhaenger_verwaltungssystem/data/models/photo.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/drift/drift_damage_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/drift/drift_photo_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/sources/photo_file_store.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late Directory root;
  late DriftDamageRepository damages;
  late DriftPhotoRepository photos;
  late File source;
  late int userId;
  late int trailerId;

  setUp(() async {
    db = createTestDatabase();
    root = await Directory.systemTemp.createTemp('anhaenger_test_');
    final PhotoFileStore files = PhotoFileStore(AppDirectories(root));
    damages = DriftDamageRepository(db, files);
    photos = DriftPhotoRepository(db, files);
    source = File('${root.path}/source.JPG');
    await source.writeAsBytes(<int>[1, 2, 3]);
    userId = await defaultUserId(db);
    trailerId = (await createTestTrailer(db)).id;
  });

  tearDown(() async {
    await db.close();
    await root.delete(recursive: true);
  });

  DamageRecordDraft draft({
    DateTime? date,
    DamageType type = DamageType.wear,
    DamageCause cause = DamageCause.internal,
    int? customerId,
  }) {
    return DamageRecordDraft(
      trailerId: trailerId,
      eventDate: date ?? DateTime(2026, 10, 1, 15, 30),
      description: 'Kratzer an der Bordwand',
      damageType: type,
      causedBy: cause,
      customerId: customerId,
      costCents: 12000,
    );
  }

  test('Schadensdatum wird ohne Uhrzeit gespeichert', () async {
    final DamageRecord record = await damages.create(draft(), userId: userId);

    expect(record.eventDate, DateTime(2026, 10, 1));
  });

  test('Kunde wird nur bei Verursacher Kunde gespeichert', () async {
    final int customerId = (await createTestCustomer(db)).id;

    final DamageRecord internal = await damages.create(
      draft(customerId: customerId),
      userId: userId,
    );
    final DamageRecord byCustomer = await damages.create(
      draft(cause: DamageCause.customer, customerId: customerId),
      userId: userId,
    );

    expect(internal.customerId, isNull);
    expect(byCustomer.customerId, customerId);
  });

  test('Filter nach Schadensart und Zeitraum, neueste zuerst', () async {
    await damages.create(draft(date: DateTime(2026, 1, 10)), userId: userId);
    await damages.create(
      draft(date: DateTime(2026, 3, 5), type: DamageType.accident),
      userId: userId,
    );
    await damages.create(draft(date: DateTime(2026, 6, 20)), userId: userId);

    final List<DamageRecord> all = await damages.watchForTrailer(trailerId).first;
    final List<DamageRecord> wear = await damages
        .watchForTrailer(
          trailerId,
          filter: DamageFilter(
            damageType: DamageType.wear,
            from: DateTime(2026, 2),
            until: DateTime(2026, 12, 31),
          ),
        )
        .first;

    expect(
      all.map((DamageRecord r) => r.eventDate),
      <DateTime>[DateTime(2026, 6, 20), DateTime(2026, 3, 5), DateTime(2026, 1, 10)],
    );
    expect(wear.map((DamageRecord r) => r.eventDate), <DateTime>[
      DateTime(2026, 6, 20),
    ]);
  });

  test('Fotos werden kopiert und beim Loeschen des Schadens entfernt',
      () async {
    final DamageRecord record = await damages.create(draft(), userId: userId);

    final Photo first = await photos.add(DamagePhotoOwner(record.id), source);
    final Photo second = await photos.add(DamagePhotoOwner(record.id), source);
    final File firstFile = photos.fileOf(first);

    expect(first.filePath, startsWith('images/damages/${record.id}/'));
    expect(first.filePath, endsWith('.jpg'));
    expect(second.sortOrder, first.sortOrder + 1);
    expect(firstFile.existsSync(), isTrue);

    await damages.delete(record.id);

    expect(await photos.watchFor(DamagePhotoOwner(record.id)).first, isEmpty);
    expect(firstFile.existsSync(), isFalse);
    expect(source.existsSync(), isTrue);
  });

  test('Foto ersetzen tauscht die Datei aus', () async {
    final Photo photo = await photos.add(TrailerPhotoOwner(trailerId), source);
    final File oldFile = photos.fileOf(photo);

    await photos.replace(photo.id, source);

    final List<Photo> current =
        await photos.watchFor(TrailerPhotoOwner(trailerId)).first;
    expect(current, hasLength(1));
    expect(current.single.filePath, isNot(photo.filePath));
    expect(oldFile.existsSync(), isFalse);
    expect(photos.fileOf(current.single).existsSync(), isTrue);
  });
}

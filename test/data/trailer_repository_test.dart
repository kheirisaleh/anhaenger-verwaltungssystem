import 'package:anhaenger_verwaltungssystem/core/database/app_database.dart';
import 'package:anhaenger_verwaltungssystem/data/models/enums.dart';
import 'package:anhaenger_verwaltungssystem/data/models/trailer.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/drift/drift_trailer_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/repository_exception.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/trailer_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late DriftTrailerRepository repository;
  late int userId;

  setUp(() async {
    db = createTestDatabase();
    repository = DriftTrailerRepository(db);
    userId = await defaultUserId(db);
  });

  tearDown(() => db.close());

  test('neuer Anhaenger ist verfuegbar und protokolliert', () async {
    final Trailer trailer = await createTestTrailer(db);

    expect(trailer.status, TrailerStatus.available);
    expect(trailer.licensePlate, 'B-AB 123');

    final List<TrailerStatusChange> history =
        await repository.watchStatusHistory(trailer.id).first;
    expect(history, hasLength(1));
    expect(history.single.oldStatus, isNull);
    expect(history.single.newStatus, TrailerStatus.available);
    expect(history.single.changedByName, AppDatabase.defaultUserName);
  });

  test('Kennzeichen wird normalisiert und ist eindeutig', () async {
    await createTestTrailer(db, licensePlate: '  b-ab   123 ');

    await expectLater(
      createTestTrailer(db, internalCode: 'A-002', licensePlate: 'B-AB 123'),
      throwsRepositoryError(RepositoryError.duplicateLicensePlate),
    );
    await expectLater(
      createTestTrailer(db, licensePlate: 'B-XY 999'),
      throwsRepositoryError(RepositoryError.duplicateInternalCode),
    );
  });

  test('Statuswechsel wird mit Benutzer protokolliert', () async {
    final Trailer trailer = await createTestTrailer(db);

    await repository.changeStatus(
      trailer.id,
      TrailerStatus.maintenance,
      userId: userId,
    );

    final Trailer? updated = await repository.watchById(trailer.id).first;
    expect(updated?.status, TrailerStatus.maintenance);
    final List<TrailerStatusChange> history =
        await repository.watchStatusHistory(trailer.id).first;
    expect(history.first.oldStatus, TrailerStatus.available);
    expect(history.first.newStatus, TrailerStatus.maintenance);
  });

  test('Vermietet kann nicht manuell gesetzt werden', () async {
    final Trailer trailer = await createTestTrailer(db);

    await expectLater(
      repository.changeStatus(trailer.id, TrailerStatus.rented, userId: userId),
      throwsRepositoryError(RepositoryError.rentedStatusManual),
    );
  });

  test('Filter nach Status und Suche', () async {
    final Trailer first = await createTestTrailer(db);
    await createTestTrailer(db, internalCode: 'B-777', licensePlate: 'DD-X 1');
    await repository.changeStatus(
      first.id,
      TrailerStatus.blocked,
      userId: userId,
    );

    final List<Trailer> blocked = await repository
        .watchAll(query: const TrailerQuery(status: TrailerStatus.blocked))
        .first;
    final List<Trailer> searched = await repository
        .watchAll(query: const TrailerQuery(search: 'b-777'))
        .first;

    expect(blocked.map((Trailer t) => t.id), <int>[first.id]);
    expect(searched.map((Trailer t) => t.internalCode), <String>['B-777']);
  });

  test('Standort wird gespeichert', () async {
    final Trailer trailer = await createTestTrailer(db);

    await repository.updateLocation(
      trailer.id,
      const TrailerLocation(
        address: 'Hof 2',
        latitude: 51.05,
        longitude: 13.74,
      ),
    );

    final Trailer? updated = await repository.watchById(trailer.id).first;
    expect(updated?.location.address, 'Hof 2');
    expect(updated?.location.hasCoordinates, isTrue);
    expect(updated?.location.updatedAt, isNotNull);
  });

  test('archivierte Anhaenger erscheinen nicht in der Liste', () async {
    final Trailer trailer = await createTestTrailer(db);

    await repository.archive(trailer.id);

    expect(await repository.watchAll().first, isEmpty);
    expect(
      await repository
          .watchAll(query: const TrailerQuery(includeArchived: true))
          .first,
      hasLength(1),
    );
  });
}

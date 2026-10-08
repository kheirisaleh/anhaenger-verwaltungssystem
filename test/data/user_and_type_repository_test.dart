import 'package:anhaenger_verwaltungssystem/core/database/app_database.dart';
import 'package:anhaenger_verwaltungssystem/data/models/app_user.dart';
import 'package:anhaenger_verwaltungssystem/data/models/trailer.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/drift/drift_trailer_type_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/drift/drift_user_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/repository_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = createTestDatabase());

  tearDown(() => db.close());

  test('deaktivierte Benutzer erscheinen nicht in der Auswahl', () async {
    final DriftUserRepository users = DriftUserRepository(db);
    final AppUser anna = await users.create('  Anna  ');

    expect(anna.name, 'Anna');
    await users.setActive(anna.id, isActive: false);

    final List<AppUser> active = await users.watchAll().first;
    final List<AppUser> all = await users.watchAll(includeInactive: true).first;
    expect(active.map((AppUser u) => u.name), <String>[
      AppDatabase.defaultUserName,
    ]);
    expect(all, hasLength(2));
    await expectLater(
      users.create('Anna'),
      throwsRepositoryError(RepositoryError.duplicateName),
    );
  });

  test('verwendeter Anhaengertyp kann nicht geloescht werden', () async {
    final DriftTrailerTypeRepository types = DriftTrailerTypeRepository(db);
    final int usedTypeId = (await createTestTrailer(db)).type.id;
    final TrailerType unused = await types.create('Bootsanhänger');

    await expectLater(
      types.delete(usedTypeId),
      throwsRepositoryError(RepositoryError.trailerTypeInUse),
    );
    await types.delete(unused.id);

    final List<TrailerType> remaining = await types.watchAll().first;
    expect(
      remaining.map((TrailerType t) => t.name),
      isNot(contains('Bootsanhänger')),
    );
  });
}

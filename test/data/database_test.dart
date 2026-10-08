import 'package:anhaenger_verwaltungssystem/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = createTestDatabase());

  tearDown(() => db.close());

  test('legt Standardbenutzer und Anhaengertypen an', () async {
    final List<AppUserRow> users = await db.select(db.appUsers).get();
    final List<TrailerTypeRow> types = await db.select(db.trailerTypes).get();

    expect(users.map((AppUserRow u) => u.name), <String>[
      AppDatabase.defaultUserName,
    ]);
    expect(
      types.map((TrailerTypeRow t) => t.name),
      unorderedEquals(AppDatabase.defaultTrailerTypes),
    );
  });

  test('Fremdschluessel sind aktiv', () async {
    await expectLater(
      db.customStatement(
        'INSERT INTO trailer (internal_code, license_plate, trailer_type_id, '
        "status) VALUES ('X', 'Y', 9999, 'available')",
      ),
      throwsA(anything),
    );
  });

  test('CHECK-Constraint lehnt unbekannten Status ab', () async {
    final int typeId = await firstTrailerTypeId(db);
    await expectLater(
      db.customStatement(
        'INSERT INTO trailer (internal_code, license_plate, trailer_type_id, '
        "status) VALUES ('X', 'Y', $typeId, 'unknown')",
      ),
      throwsA(anything),
    );
  });

  test('CHECK-Constraint verlangt Mietende nach Mietbeginn', () async {
    final int userId = await defaultUserId(db);
    final int trailerId = (await createTestTrailer(db)).id;
    final int customerId = (await createTestCustomer(db)).id;
    await expectLater(
      db.customStatement(
        'INSERT INTO rental_contract (customer_id, trailer_id, start_at, '
        'end_at, pickup_location, return_location, price_cents, status, '
        'created_by_user_id) VALUES ($customerId, $trailerId, 200, 100, '
        "'A', 'B', 0, 'planned', $userId)",
      ),
      throwsA(anything),
    );
  });
}

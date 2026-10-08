import 'package:anhaenger_verwaltungssystem/core/database/app_database.dart';
import 'package:anhaenger_verwaltungssystem/data/models/customer.dart';
import 'package:anhaenger_verwaltungssystem/data/models/trailer.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/drift/drift_customer_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/drift/drift_trailer_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/repository_exception.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

AppDatabase createTestDatabase() {
  return AppDatabase(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
}

Future<int> defaultUserId(AppDatabase db) async {
  final AppUserRow user = await (db.select(db.appUsers)
        ..where(($AppUsersTable t) => t.name.equals(AppDatabase.defaultUserName)))
      .getSingle();
  return user.id;
}

Future<int> firstTrailerTypeId(AppDatabase db) async {
  final List<TrailerTypeRow> types = await db.select(db.trailerTypes).get();
  return types.first.id;
}

Future<Trailer> createTestTrailer(
  AppDatabase db, {
  String internalCode = 'A-001',
  String licensePlate = 'B-AB 123',
}) async {
  return DriftTrailerRepository(db).create(
    TrailerDraft(
      internalCode: internalCode,
      licensePlate: licensePlate,
      typeId: await firstTrailerTypeId(db),
    ),
    userId: await defaultUserId(db),
  );
}

Future<Customer> createTestCustomer(AppDatabase db) {
  return DriftCustomerRepository(db).create(
    const CustomerDraft(
      firstName: 'Max',
      lastName: 'Mustermann',
      email: 'max@example.de',
      phone: '030 123456',
      street: 'Hauptstraße 1',
      postalCode: '01067',
      city: 'Dresden',
    ),
  );
}

Matcher throwsRepositoryError(RepositoryError error) {
  return throwsA(
    isA<RepositoryException>().having(
      (RepositoryException e) => e.error,
      'error',
      error,
    ),
  );
}

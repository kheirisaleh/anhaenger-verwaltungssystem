import 'package:drift/drift.dart';

import '../../data/models/enums.dart';

@DataClassName('AppUserRow')
class AppUsers extends Table {
  @override
  String get tableName => 'app_user';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('TrailerTypeRow')
class TrailerTypes extends Table {
  @override
  String get tableName => 'trailer_type';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('TrailerRow')
@TableIndex(name: 'trailer_status_idx', columns: <Symbol>{#status})
class Trailers extends Table {
  @override
  String get tableName => 'trailer';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get internalCode => text().unique()();
  TextColumn get licensePlate => text().unique()();
  IntColumn get trailerTypeId => integer().references(
    TrailerTypes,
    #id,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get status => textEnum<TrailerStatus>()();
  TextColumn get locationAddress => text().nullable()();
  RealColumn get locationLatitude => real().nullable()();
  RealColumn get locationLongitude => real().nullable()();
  DateTimeColumn get locationUpdatedAt => dateTime().nullable()();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => <String>[
    "CHECK (status IN ('available', 'rented', 'maintenance', 'blocked'))",
    'CHECK (location_latitude IS NULL OR location_latitude BETWEEN -90 AND 90)',
    'CHECK (location_longitude IS NULL OR location_longitude BETWEEN -180 AND 180)',
  ];
}

@DataClassName('TrailerStatusChangeRow')
@TableIndex(
  name: 'trailer_status_change_trailer_idx',
  columns: <Symbol>{#trailerId, #changedAt},
)
class TrailerStatusChanges extends Table {
  @override
  String get tableName => 'trailer_status_change';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get trailerId => integer().references(
    Trailers,
    #id,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get oldStatus => textEnum<TrailerStatus>().nullable()();
  TextColumn get newStatus => textEnum<TrailerStatus>()();
  DateTimeColumn get changedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get changedByUserId => integer().references(
    AppUsers,
    #id,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get rentalContractId => integer().nullable().references(
    RentalContracts,
    #id,
    onDelete: KeyAction.restrict,
  )();

  @override
  List<String> get customConstraints => <String>[
    "CHECK (old_status IS NULL OR old_status IN ('available', 'rented', 'maintenance', 'blocked'))",
    "CHECK (new_status IN ('available', 'rented', 'maintenance', 'blocked'))",
  ];
}

@DataClassName('CustomerRow')
class Customers extends Table {
  @override
  String get tableName => 'customer';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get street => text()();
  TextColumn get postalCode => text()();
  TextColumn get city => text()();
  TextColumn get licenseNumber => text().nullable()();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('RentalContractRow')
@TableIndex(
  name: 'rental_contract_trailer_idx',
  columns: <Symbol>{#trailerId, #startAt},
)
@TableIndex(
  name: 'rental_contract_customer_idx',
  columns: <Symbol>{#customerId},
)
@TableIndex(
  name: 'rental_contract_status_idx',
  columns: <Symbol>{#status, #startAt},
)
class RentalContracts extends Table {
  @override
  String get tableName => 'rental_contract';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(
    Customers,
    #id,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get trailerId => integer().references(
    Trailers,
    #id,
    onDelete: KeyAction.restrict,
  )();
  DateTimeColumn get startAt => dateTime()();
  DateTimeColumn get endAt => dateTime()();
  TextColumn get pickupLocation => text()();
  TextColumn get returnLocation => text()();
  IntColumn get priceCents => integer()();
  TextColumn get status => textEnum<ContractStatus>()();
  DateTimeColumn get handedOverAt => dateTime().nullable()();
  DateTimeColumn get returnedAt => dateTime().nullable()();
  IntColumn get createdByUserId => integer().references(
    AppUsers,
    #id,
    onDelete: KeyAction.restrict,
  )();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => <String>[
    'CHECK (end_at > start_at)',
    'CHECK (price_cents >= 0)',
    "CHECK (status IN ('planned', 'active', 'completed', 'cancelled'))",
  ];
}

@DataClassName('DamageRecordRow')
@TableIndex(
  name: 'damage_record_trailer_idx',
  columns: <Symbol>{#trailerId, #eventDate},
)
class DamageRecords extends Table {
  @override
  String get tableName => 'damage_record';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get trailerId => integer().references(
    Trailers,
    #id,
    onDelete: KeyAction.restrict,
  )();
  DateTimeColumn get eventDate => dateTime()();
  TextColumn get description => text()();
  TextColumn get damageType => textEnum<DamageType>()();
  TextColumn get causedBy => textEnum<DamageCause>()();
  IntColumn get customerId => integer().nullable().references(
    Customers,
    #id,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get rentalContractId => integer().nullable().references(
    RentalContracts,
    #id,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get costCents => integer().nullable()();
  IntColumn get createdByUserId => integer().references(
    AppUsers,
    #id,
    onDelete: KeyAction.restrict,
  )();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => <String>[
    'CHECK (cost_cents IS NULL OR cost_cents >= 0)',
    "CHECK (damage_type IN ('accident', 'vandalism', 'wear', 'other'))",
    "CHECK (caused_by IN ('customer', 'internal', 'unknown'))",
  ];
}

@DataClassName('PhotoRow')
@TableIndex(name: 'photo_trailer_idx', columns: <Symbol>{#trailerId})
@TableIndex(name: 'photo_damage_record_idx', columns: <Symbol>{#damageRecordId})
class Photos extends Table {
  @override
  String get tableName => 'photo';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get trailerId => integer().nullable().references(
    Trailers,
    #id,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get damageRecordId => integer().nullable().references(
    DamageRecords,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get filePath => text().unique()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => <String>[
    'CHECK ((trailer_id IS NULL) <> (damage_record_id IS NULL))',
  ];
}

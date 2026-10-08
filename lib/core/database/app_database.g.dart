// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppUsersTable extends AppUsers
    with TableInfo<$AppUsersTable, AppUserRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_user';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppUserRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppUserRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUserRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppUsersTable createAlias(String alias) {
    return $AppUsersTable(attachedDatabase, alias);
  }
}

class AppUserRow extends DataClass implements Insertable<AppUserRow> {
  final int id;
  final String name;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppUserRow({
    required this.id,
    required this.name,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppUsersCompanion toCompanion(bool nullToAbsent) {
    return AppUsersCompanion(
      id: Value(id),
      name: Value(name),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppUserRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUserRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppUserRow copyWith({
    int? id,
    String? name,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppUserRow(
    id: id ?? this.id,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppUserRow copyWithCompanion(AppUsersCompanion data) {
    return AppUserRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppUserRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUserRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppUsersCompanion extends UpdateCompanion<AppUserRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AppUsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppUsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<AppUserRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppUsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return AppUsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppUsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TrailerTypesTable extends TrailerTypes
    with TableInfo<$TrailerTypesTable, TrailerTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrailerTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trailer_type';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrailerTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrailerTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrailerTypeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TrailerTypesTable createAlias(String alias) {
    return $TrailerTypesTable(attachedDatabase, alias);
  }
}

class TrailerTypeRow extends DataClass implements Insertable<TrailerTypeRow> {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TrailerTypeRow({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TrailerTypesCompanion toCompanion(bool nullToAbsent) {
    return TrailerTypesCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TrailerTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrailerTypeRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TrailerTypeRow copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TrailerTypeRow(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TrailerTypeRow copyWithCompanion(TrailerTypesCompanion data) {
    return TrailerTypeRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrailerTypeRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrailerTypeRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TrailerTypesCompanion extends UpdateCompanion<TrailerTypeRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TrailerTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TrailerTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<TrailerTypeRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TrailerTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TrailerTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrailerTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TrailersTable extends Trailers
    with TableInfo<$TrailersTable, TrailerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrailersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _internalCodeMeta = const VerificationMeta(
    'internalCode',
  );
  @override
  late final GeneratedColumn<String> internalCode = GeneratedColumn<String>(
    'internal_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _licensePlateMeta = const VerificationMeta(
    'licensePlate',
  );
  @override
  late final GeneratedColumn<String> licensePlate = GeneratedColumn<String>(
    'license_plate',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _trailerTypeIdMeta = const VerificationMeta(
    'trailerTypeId',
  );
  @override
  late final GeneratedColumn<int> trailerTypeId = GeneratedColumn<int>(
    'trailer_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trailer_type (id) ON DELETE RESTRICT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TrailerStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TrailerStatus>($TrailersTable.$converterstatus);
  static const VerificationMeta _locationAddressMeta = const VerificationMeta(
    'locationAddress',
  );
  @override
  late final GeneratedColumn<String> locationAddress = GeneratedColumn<String>(
    'location_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationLatitudeMeta = const VerificationMeta(
    'locationLatitude',
  );
  @override
  late final GeneratedColumn<double> locationLatitude = GeneratedColumn<double>(
    'location_latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationLongitudeMeta = const VerificationMeta(
    'locationLongitude',
  );
  @override
  late final GeneratedColumn<double> locationLongitude =
      GeneratedColumn<double>(
        'location_longitude',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _locationUpdatedAtMeta = const VerificationMeta(
    'locationUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> locationUpdatedAt =
      GeneratedColumn<DateTime>(
        'location_updated_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    internalCode,
    licensePlate,
    trailerTypeId,
    status,
    locationAddress,
    locationLatitude,
    locationLongitude,
    locationUpdatedAt,
    archivedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trailer';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrailerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('internal_code')) {
      context.handle(
        _internalCodeMeta,
        internalCode.isAcceptableOrUnknown(
          data['internal_code']!,
          _internalCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_internalCodeMeta);
    }
    if (data.containsKey('license_plate')) {
      context.handle(
        _licensePlateMeta,
        licensePlate.isAcceptableOrUnknown(
          data['license_plate']!,
          _licensePlateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licensePlateMeta);
    }
    if (data.containsKey('trailer_type_id')) {
      context.handle(
        _trailerTypeIdMeta,
        trailerTypeId.isAcceptableOrUnknown(
          data['trailer_type_id']!,
          _trailerTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trailerTypeIdMeta);
    }
    if (data.containsKey('location_address')) {
      context.handle(
        _locationAddressMeta,
        locationAddress.isAcceptableOrUnknown(
          data['location_address']!,
          _locationAddressMeta,
        ),
      );
    }
    if (data.containsKey('location_latitude')) {
      context.handle(
        _locationLatitudeMeta,
        locationLatitude.isAcceptableOrUnknown(
          data['location_latitude']!,
          _locationLatitudeMeta,
        ),
      );
    }
    if (data.containsKey('location_longitude')) {
      context.handle(
        _locationLongitudeMeta,
        locationLongitude.isAcceptableOrUnknown(
          data['location_longitude']!,
          _locationLongitudeMeta,
        ),
      );
    }
    if (data.containsKey('location_updated_at')) {
      context.handle(
        _locationUpdatedAtMeta,
        locationUpdatedAt.isAcceptableOrUnknown(
          data['location_updated_at']!,
          _locationUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrailerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrailerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      internalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}internal_code'],
      )!,
      licensePlate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_plate'],
      )!,
      trailerTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trailer_type_id'],
      )!,
      status: $TrailersTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      locationAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_address'],
      ),
      locationLatitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}location_latitude'],
      ),
      locationLongitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}location_longitude'],
      ),
      locationUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}location_updated_at'],
      ),
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TrailersTable createAlias(String alias) {
    return $TrailersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TrailerStatus, String, String> $converterstatus =
      const EnumNameConverter<TrailerStatus>(TrailerStatus.values);
}

class TrailerRow extends DataClass implements Insertable<TrailerRow> {
  final int id;
  final String internalCode;
  final String licensePlate;
  final int trailerTypeId;
  final TrailerStatus status;
  final String? locationAddress;
  final double? locationLatitude;
  final double? locationLongitude;
  final DateTime? locationUpdatedAt;
  final DateTime? archivedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TrailerRow({
    required this.id,
    required this.internalCode,
    required this.licensePlate,
    required this.trailerTypeId,
    required this.status,
    this.locationAddress,
    this.locationLatitude,
    this.locationLongitude,
    this.locationUpdatedAt,
    this.archivedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['internal_code'] = Variable<String>(internalCode);
    map['license_plate'] = Variable<String>(licensePlate);
    map['trailer_type_id'] = Variable<int>(trailerTypeId);
    {
      map['status'] = Variable<String>(
        $TrailersTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || locationAddress != null) {
      map['location_address'] = Variable<String>(locationAddress);
    }
    if (!nullToAbsent || locationLatitude != null) {
      map['location_latitude'] = Variable<double>(locationLatitude);
    }
    if (!nullToAbsent || locationLongitude != null) {
      map['location_longitude'] = Variable<double>(locationLongitude);
    }
    if (!nullToAbsent || locationUpdatedAt != null) {
      map['location_updated_at'] = Variable<DateTime>(locationUpdatedAt);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TrailersCompanion toCompanion(bool nullToAbsent) {
    return TrailersCompanion(
      id: Value(id),
      internalCode: Value(internalCode),
      licensePlate: Value(licensePlate),
      trailerTypeId: Value(trailerTypeId),
      status: Value(status),
      locationAddress: locationAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(locationAddress),
      locationLatitude: locationLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLatitude),
      locationLongitude: locationLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(locationLongitude),
      locationUpdatedAt: locationUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(locationUpdatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TrailerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrailerRow(
      id: serializer.fromJson<int>(json['id']),
      internalCode: serializer.fromJson<String>(json['internalCode']),
      licensePlate: serializer.fromJson<String>(json['licensePlate']),
      trailerTypeId: serializer.fromJson<int>(json['trailerTypeId']),
      status: $TrailersTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      locationAddress: serializer.fromJson<String?>(json['locationAddress']),
      locationLatitude: serializer.fromJson<double?>(json['locationLatitude']),
      locationLongitude: serializer.fromJson<double?>(
        json['locationLongitude'],
      ),
      locationUpdatedAt: serializer.fromJson<DateTime?>(
        json['locationUpdatedAt'],
      ),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'internalCode': serializer.toJson<String>(internalCode),
      'licensePlate': serializer.toJson<String>(licensePlate),
      'trailerTypeId': serializer.toJson<int>(trailerTypeId),
      'status': serializer.toJson<String>(
        $TrailersTable.$converterstatus.toJson(status),
      ),
      'locationAddress': serializer.toJson<String?>(locationAddress),
      'locationLatitude': serializer.toJson<double?>(locationLatitude),
      'locationLongitude': serializer.toJson<double?>(locationLongitude),
      'locationUpdatedAt': serializer.toJson<DateTime?>(locationUpdatedAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TrailerRow copyWith({
    int? id,
    String? internalCode,
    String? licensePlate,
    int? trailerTypeId,
    TrailerStatus? status,
    Value<String?> locationAddress = const Value.absent(),
    Value<double?> locationLatitude = const Value.absent(),
    Value<double?> locationLongitude = const Value.absent(),
    Value<DateTime?> locationUpdatedAt = const Value.absent(),
    Value<DateTime?> archivedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TrailerRow(
    id: id ?? this.id,
    internalCode: internalCode ?? this.internalCode,
    licensePlate: licensePlate ?? this.licensePlate,
    trailerTypeId: trailerTypeId ?? this.trailerTypeId,
    status: status ?? this.status,
    locationAddress: locationAddress.present
        ? locationAddress.value
        : this.locationAddress,
    locationLatitude: locationLatitude.present
        ? locationLatitude.value
        : this.locationLatitude,
    locationLongitude: locationLongitude.present
        ? locationLongitude.value
        : this.locationLongitude,
    locationUpdatedAt: locationUpdatedAt.present
        ? locationUpdatedAt.value
        : this.locationUpdatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TrailerRow copyWithCompanion(TrailersCompanion data) {
    return TrailerRow(
      id: data.id.present ? data.id.value : this.id,
      internalCode: data.internalCode.present
          ? data.internalCode.value
          : this.internalCode,
      licensePlate: data.licensePlate.present
          ? data.licensePlate.value
          : this.licensePlate,
      trailerTypeId: data.trailerTypeId.present
          ? data.trailerTypeId.value
          : this.trailerTypeId,
      status: data.status.present ? data.status.value : this.status,
      locationAddress: data.locationAddress.present
          ? data.locationAddress.value
          : this.locationAddress,
      locationLatitude: data.locationLatitude.present
          ? data.locationLatitude.value
          : this.locationLatitude,
      locationLongitude: data.locationLongitude.present
          ? data.locationLongitude.value
          : this.locationLongitude,
      locationUpdatedAt: data.locationUpdatedAt.present
          ? data.locationUpdatedAt.value
          : this.locationUpdatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrailerRow(')
          ..write('id: $id, ')
          ..write('internalCode: $internalCode, ')
          ..write('licensePlate: $licensePlate, ')
          ..write('trailerTypeId: $trailerTypeId, ')
          ..write('status: $status, ')
          ..write('locationAddress: $locationAddress, ')
          ..write('locationLatitude: $locationLatitude, ')
          ..write('locationLongitude: $locationLongitude, ')
          ..write('locationUpdatedAt: $locationUpdatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    internalCode,
    licensePlate,
    trailerTypeId,
    status,
    locationAddress,
    locationLatitude,
    locationLongitude,
    locationUpdatedAt,
    archivedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrailerRow &&
          other.id == this.id &&
          other.internalCode == this.internalCode &&
          other.licensePlate == this.licensePlate &&
          other.trailerTypeId == this.trailerTypeId &&
          other.status == this.status &&
          other.locationAddress == this.locationAddress &&
          other.locationLatitude == this.locationLatitude &&
          other.locationLongitude == this.locationLongitude &&
          other.locationUpdatedAt == this.locationUpdatedAt &&
          other.archivedAt == this.archivedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TrailersCompanion extends UpdateCompanion<TrailerRow> {
  final Value<int> id;
  final Value<String> internalCode;
  final Value<String> licensePlate;
  final Value<int> trailerTypeId;
  final Value<TrailerStatus> status;
  final Value<String?> locationAddress;
  final Value<double?> locationLatitude;
  final Value<double?> locationLongitude;
  final Value<DateTime?> locationUpdatedAt;
  final Value<DateTime?> archivedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TrailersCompanion({
    this.id = const Value.absent(),
    this.internalCode = const Value.absent(),
    this.licensePlate = const Value.absent(),
    this.trailerTypeId = const Value.absent(),
    this.status = const Value.absent(),
    this.locationAddress = const Value.absent(),
    this.locationLatitude = const Value.absent(),
    this.locationLongitude = const Value.absent(),
    this.locationUpdatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TrailersCompanion.insert({
    this.id = const Value.absent(),
    required String internalCode,
    required String licensePlate,
    required int trailerTypeId,
    required TrailerStatus status,
    this.locationAddress = const Value.absent(),
    this.locationLatitude = const Value.absent(),
    this.locationLongitude = const Value.absent(),
    this.locationUpdatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : internalCode = Value(internalCode),
       licensePlate = Value(licensePlate),
       trailerTypeId = Value(trailerTypeId),
       status = Value(status);
  static Insertable<TrailerRow> custom({
    Expression<int>? id,
    Expression<String>? internalCode,
    Expression<String>? licensePlate,
    Expression<int>? trailerTypeId,
    Expression<String>? status,
    Expression<String>? locationAddress,
    Expression<double>? locationLatitude,
    Expression<double>? locationLongitude,
    Expression<DateTime>? locationUpdatedAt,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (internalCode != null) 'internal_code': internalCode,
      if (licensePlate != null) 'license_plate': licensePlate,
      if (trailerTypeId != null) 'trailer_type_id': trailerTypeId,
      if (status != null) 'status': status,
      if (locationAddress != null) 'location_address': locationAddress,
      if (locationLatitude != null) 'location_latitude': locationLatitude,
      if (locationLongitude != null) 'location_longitude': locationLongitude,
      if (locationUpdatedAt != null) 'location_updated_at': locationUpdatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TrailersCompanion copyWith({
    Value<int>? id,
    Value<String>? internalCode,
    Value<String>? licensePlate,
    Value<int>? trailerTypeId,
    Value<TrailerStatus>? status,
    Value<String?>? locationAddress,
    Value<double?>? locationLatitude,
    Value<double?>? locationLongitude,
    Value<DateTime?>? locationUpdatedAt,
    Value<DateTime?>? archivedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TrailersCompanion(
      id: id ?? this.id,
      internalCode: internalCode ?? this.internalCode,
      licensePlate: licensePlate ?? this.licensePlate,
      trailerTypeId: trailerTypeId ?? this.trailerTypeId,
      status: status ?? this.status,
      locationAddress: locationAddress ?? this.locationAddress,
      locationLatitude: locationLatitude ?? this.locationLatitude,
      locationLongitude: locationLongitude ?? this.locationLongitude,
      locationUpdatedAt: locationUpdatedAt ?? this.locationUpdatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (internalCode.present) {
      map['internal_code'] = Variable<String>(internalCode.value);
    }
    if (licensePlate.present) {
      map['license_plate'] = Variable<String>(licensePlate.value);
    }
    if (trailerTypeId.present) {
      map['trailer_type_id'] = Variable<int>(trailerTypeId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $TrailersTable.$converterstatus.toSql(status.value),
      );
    }
    if (locationAddress.present) {
      map['location_address'] = Variable<String>(locationAddress.value);
    }
    if (locationLatitude.present) {
      map['location_latitude'] = Variable<double>(locationLatitude.value);
    }
    if (locationLongitude.present) {
      map['location_longitude'] = Variable<double>(locationLongitude.value);
    }
    if (locationUpdatedAt.present) {
      map['location_updated_at'] = Variable<DateTime>(locationUpdatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrailersCompanion(')
          ..write('id: $id, ')
          ..write('internalCode: $internalCode, ')
          ..write('licensePlate: $licensePlate, ')
          ..write('trailerTypeId: $trailerTypeId, ')
          ..write('status: $status, ')
          ..write('locationAddress: $locationAddress, ')
          ..write('locationLatitude: $locationLatitude, ')
          ..write('locationLongitude: $locationLongitude, ')
          ..write('locationUpdatedAt: $locationUpdatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, CustomerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _streetMeta = const VerificationMeta('street');
  @override
  late final GeneratedColumn<String> street = GeneratedColumn<String>(
    'street',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licenseNumberMeta = const VerificationMeta(
    'licenseNumber',
  );
  @override
  late final GeneratedColumn<String> licenseNumber = GeneratedColumn<String>(
    'license_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    email,
    phone,
    street,
    postalCode,
    city,
    licenseNumber,
    archivedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('street')) {
      context.handle(
        _streetMeta,
        street.isAcceptableOrUnknown(data['street']!, _streetMeta),
      );
    } else if (isInserting) {
      context.missing(_streetMeta);
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_postalCodeMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('license_number')) {
      context.handle(
        _licenseNumberMeta,
        licenseNumber.isAcceptableOrUnknown(
          data['license_number']!,
          _licenseNumberMeta,
        ),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      street: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}street'],
      )!,
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      licenseNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_number'],
      ),
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class CustomerRow extends DataClass implements Insertable<CustomerRow> {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String street;
  final String postalCode;
  final String city;
  final String? licenseNumber;
  final DateTime? archivedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CustomerRow({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.street,
    required this.postalCode,
    required this.city,
    this.licenseNumber,
    this.archivedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['street'] = Variable<String>(street);
    map['postal_code'] = Variable<String>(postalCode);
    map['city'] = Variable<String>(city);
    if (!nullToAbsent || licenseNumber != null) {
      map['license_number'] = Variable<String>(licenseNumber);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      phone: Value(phone),
      street: Value(street),
      postalCode: Value(postalCode),
      city: Value(city),
      licenseNumber: licenseNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(licenseNumber),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CustomerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerRow(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      street: serializer.fromJson<String>(json['street']),
      postalCode: serializer.fromJson<String>(json['postalCode']),
      city: serializer.fromJson<String>(json['city']),
      licenseNumber: serializer.fromJson<String?>(json['licenseNumber']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'street': serializer.toJson<String>(street),
      'postalCode': serializer.toJson<String>(postalCode),
      'city': serializer.toJson<String>(city),
      'licenseNumber': serializer.toJson<String?>(licenseNumber),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CustomerRow copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? street,
    String? postalCode,
    String? city,
    Value<String?> licenseNumber = const Value.absent(),
    Value<DateTime?> archivedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CustomerRow(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    street: street ?? this.street,
    postalCode: postalCode ?? this.postalCode,
    city: city ?? this.city,
    licenseNumber: licenseNumber.present
        ? licenseNumber.value
        : this.licenseNumber,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CustomerRow copyWithCompanion(CustomersCompanion data) {
    return CustomerRow(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      street: data.street.present ? data.street.value : this.street,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      city: data.city.present ? data.city.value : this.city,
      licenseNumber: data.licenseNumber.present
          ? data.licenseNumber.value
          : this.licenseNumber,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerRow(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('street: $street, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('licenseNumber: $licenseNumber, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    firstName,
    lastName,
    email,
    phone,
    street,
    postalCode,
    city,
    licenseNumber,
    archivedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerRow &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.street == this.street &&
          other.postalCode == this.postalCode &&
          other.city == this.city &&
          other.licenseNumber == this.licenseNumber &&
          other.archivedAt == this.archivedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CustomersCompanion extends UpdateCompanion<CustomerRow> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> street;
  final Value<String> postalCode;
  final Value<String> city;
  final Value<String?> licenseNumber;
  final Value<DateTime?> archivedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.street = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.licenseNumber = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String street,
    required String postalCode,
    required String city,
    this.licenseNumber = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       email = Value(email),
       phone = Value(phone),
       street = Value(street),
       postalCode = Value(postalCode),
       city = Value(city);
  static Insertable<CustomerRow> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? street,
    Expression<String>? postalCode,
    Expression<String>? city,
    Expression<String>? licenseNumber,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (street != null) 'street': street,
      if (postalCode != null) 'postal_code': postalCode,
      if (city != null) 'city': city,
      if (licenseNumber != null) 'license_number': licenseNumber,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? email,
    Value<String>? phone,
    Value<String>? street,
    Value<String>? postalCode,
    Value<String>? city,
    Value<String?>? licenseNumber,
    Value<DateTime?>? archivedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      archivedAt: archivedAt ?? this.archivedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (street.present) {
      map['street'] = Variable<String>(street.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (licenseNumber.present) {
      map['license_number'] = Variable<String>(licenseNumber.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('street: $street, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('licenseNumber: $licenseNumber, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RentalContractsTable extends RentalContracts
    with TableInfo<$RentalContractsTable, RentalContractRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RentalContractsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customer (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _trailerIdMeta = const VerificationMeta(
    'trailerId',
  );
  @override
  late final GeneratedColumn<int> trailerId = GeneratedColumn<int>(
    'trailer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trailer (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<DateTime> endAt = GeneratedColumn<DateTime>(
    'end_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pickupLocationMeta = const VerificationMeta(
    'pickupLocation',
  );
  @override
  late final GeneratedColumn<String> pickupLocation = GeneratedColumn<String>(
    'pickup_location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnLocationMeta = const VerificationMeta(
    'returnLocation',
  );
  @override
  late final GeneratedColumn<String> returnLocation = GeneratedColumn<String>(
    'return_location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceCentsMeta = const VerificationMeta(
    'priceCents',
  );
  @override
  late final GeneratedColumn<int> priceCents = GeneratedColumn<int>(
    'price_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ContractStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ContractStatus>($RentalContractsTable.$converterstatus);
  static const VerificationMeta _handedOverAtMeta = const VerificationMeta(
    'handedOverAt',
  );
  @override
  late final GeneratedColumn<DateTime> handedOverAt = GeneratedColumn<DateTime>(
    'handed_over_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _returnedAtMeta = const VerificationMeta(
    'returnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> returnedAt = GeneratedColumn<DateTime>(
    'returned_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByUserIdMeta = const VerificationMeta(
    'createdByUserId',
  );
  @override
  late final GeneratedColumn<int> createdByUserId = GeneratedColumn<int>(
    'created_by_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_user (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    trailerId,
    startAt,
    endAt,
    pickupLocation,
    returnLocation,
    priceCents,
    status,
    handedOverAt,
    returnedAt,
    createdByUserId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rental_contract';
  @override
  VerificationContext validateIntegrity(
    Insertable<RentalContractRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('trailer_id')) {
      context.handle(
        _trailerIdMeta,
        trailerId.isAcceptableOrUnknown(data['trailer_id']!, _trailerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trailerIdMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endAtMeta);
    }
    if (data.containsKey('pickup_location')) {
      context.handle(
        _pickupLocationMeta,
        pickupLocation.isAcceptableOrUnknown(
          data['pickup_location']!,
          _pickupLocationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pickupLocationMeta);
    }
    if (data.containsKey('return_location')) {
      context.handle(
        _returnLocationMeta,
        returnLocation.isAcceptableOrUnknown(
          data['return_location']!,
          _returnLocationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_returnLocationMeta);
    }
    if (data.containsKey('price_cents')) {
      context.handle(
        _priceCentsMeta,
        priceCents.isAcceptableOrUnknown(data['price_cents']!, _priceCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_priceCentsMeta);
    }
    if (data.containsKey('handed_over_at')) {
      context.handle(
        _handedOverAtMeta,
        handedOverAt.isAcceptableOrUnknown(
          data['handed_over_at']!,
          _handedOverAtMeta,
        ),
      );
    }
    if (data.containsKey('returned_at')) {
      context.handle(
        _returnedAtMeta,
        returnedAt.isAcceptableOrUnknown(data['returned_at']!, _returnedAtMeta),
      );
    }
    if (data.containsKey('created_by_user_id')) {
      context.handle(
        _createdByUserIdMeta,
        createdByUserId.isAcceptableOrUnknown(
          data['created_by_user_id']!,
          _createdByUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdByUserIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RentalContractRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RentalContractRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      trailerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trailer_id'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_at'],
      )!,
      pickupLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pickup_location'],
      )!,
      returnLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_location'],
      )!,
      priceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_cents'],
      )!,
      status: $RentalContractsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      handedOverAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}handed_over_at'],
      ),
      returnedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}returned_at'],
      ),
      createdByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_by_user_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RentalContractsTable createAlias(String alias) {
    return $RentalContractsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ContractStatus, String, String> $converterstatus =
      const EnumNameConverter<ContractStatus>(ContractStatus.values);
}

class RentalContractRow extends DataClass
    implements Insertable<RentalContractRow> {
  final int id;
  final int customerId;
  final int trailerId;
  final DateTime startAt;
  final DateTime endAt;
  final String pickupLocation;
  final String returnLocation;
  final int priceCents;
  final ContractStatus status;
  final DateTime? handedOverAt;
  final DateTime? returnedAt;
  final int createdByUserId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RentalContractRow({
    required this.id,
    required this.customerId,
    required this.trailerId,
    required this.startAt,
    required this.endAt,
    required this.pickupLocation,
    required this.returnLocation,
    required this.priceCents,
    required this.status,
    this.handedOverAt,
    this.returnedAt,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['trailer_id'] = Variable<int>(trailerId);
    map['start_at'] = Variable<DateTime>(startAt);
    map['end_at'] = Variable<DateTime>(endAt);
    map['pickup_location'] = Variable<String>(pickupLocation);
    map['return_location'] = Variable<String>(returnLocation);
    map['price_cents'] = Variable<int>(priceCents);
    {
      map['status'] = Variable<String>(
        $RentalContractsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || handedOverAt != null) {
      map['handed_over_at'] = Variable<DateTime>(handedOverAt);
    }
    if (!nullToAbsent || returnedAt != null) {
      map['returned_at'] = Variable<DateTime>(returnedAt);
    }
    map['created_by_user_id'] = Variable<int>(createdByUserId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RentalContractsCompanion toCompanion(bool nullToAbsent) {
    return RentalContractsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      trailerId: Value(trailerId),
      startAt: Value(startAt),
      endAt: Value(endAt),
      pickupLocation: Value(pickupLocation),
      returnLocation: Value(returnLocation),
      priceCents: Value(priceCents),
      status: Value(status),
      handedOverAt: handedOverAt == null && nullToAbsent
          ? const Value.absent()
          : Value(handedOverAt),
      returnedAt: returnedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(returnedAt),
      createdByUserId: Value(createdByUserId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RentalContractRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RentalContractRow(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      trailerId: serializer.fromJson<int>(json['trailerId']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      endAt: serializer.fromJson<DateTime>(json['endAt']),
      pickupLocation: serializer.fromJson<String>(json['pickupLocation']),
      returnLocation: serializer.fromJson<String>(json['returnLocation']),
      priceCents: serializer.fromJson<int>(json['priceCents']),
      status: $RentalContractsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      handedOverAt: serializer.fromJson<DateTime?>(json['handedOverAt']),
      returnedAt: serializer.fromJson<DateTime?>(json['returnedAt']),
      createdByUserId: serializer.fromJson<int>(json['createdByUserId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'trailerId': serializer.toJson<int>(trailerId),
      'startAt': serializer.toJson<DateTime>(startAt),
      'endAt': serializer.toJson<DateTime>(endAt),
      'pickupLocation': serializer.toJson<String>(pickupLocation),
      'returnLocation': serializer.toJson<String>(returnLocation),
      'priceCents': serializer.toJson<int>(priceCents),
      'status': serializer.toJson<String>(
        $RentalContractsTable.$converterstatus.toJson(status),
      ),
      'handedOverAt': serializer.toJson<DateTime?>(handedOverAt),
      'returnedAt': serializer.toJson<DateTime?>(returnedAt),
      'createdByUserId': serializer.toJson<int>(createdByUserId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RentalContractRow copyWith({
    int? id,
    int? customerId,
    int? trailerId,
    DateTime? startAt,
    DateTime? endAt,
    String? pickupLocation,
    String? returnLocation,
    int? priceCents,
    ContractStatus? status,
    Value<DateTime?> handedOverAt = const Value.absent(),
    Value<DateTime?> returnedAt = const Value.absent(),
    int? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RentalContractRow(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    trailerId: trailerId ?? this.trailerId,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    pickupLocation: pickupLocation ?? this.pickupLocation,
    returnLocation: returnLocation ?? this.returnLocation,
    priceCents: priceCents ?? this.priceCents,
    status: status ?? this.status,
    handedOverAt: handedOverAt.present ? handedOverAt.value : this.handedOverAt,
    returnedAt: returnedAt.present ? returnedAt.value : this.returnedAt,
    createdByUserId: createdByUserId ?? this.createdByUserId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RentalContractRow copyWithCompanion(RentalContractsCompanion data) {
    return RentalContractRow(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      trailerId: data.trailerId.present ? data.trailerId.value : this.trailerId,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      pickupLocation: data.pickupLocation.present
          ? data.pickupLocation.value
          : this.pickupLocation,
      returnLocation: data.returnLocation.present
          ? data.returnLocation.value
          : this.returnLocation,
      priceCents: data.priceCents.present
          ? data.priceCents.value
          : this.priceCents,
      status: data.status.present ? data.status.value : this.status,
      handedOverAt: data.handedOverAt.present
          ? data.handedOverAt.value
          : this.handedOverAt,
      returnedAt: data.returnedAt.present
          ? data.returnedAt.value
          : this.returnedAt,
      createdByUserId: data.createdByUserId.present
          ? data.createdByUserId.value
          : this.createdByUserId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RentalContractRow(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('trailerId: $trailerId, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('pickupLocation: $pickupLocation, ')
          ..write('returnLocation: $returnLocation, ')
          ..write('priceCents: $priceCents, ')
          ..write('status: $status, ')
          ..write('handedOverAt: $handedOverAt, ')
          ..write('returnedAt: $returnedAt, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerId,
    trailerId,
    startAt,
    endAt,
    pickupLocation,
    returnLocation,
    priceCents,
    status,
    handedOverAt,
    returnedAt,
    createdByUserId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RentalContractRow &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.trailerId == this.trailerId &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.pickupLocation == this.pickupLocation &&
          other.returnLocation == this.returnLocation &&
          other.priceCents == this.priceCents &&
          other.status == this.status &&
          other.handedOverAt == this.handedOverAt &&
          other.returnedAt == this.returnedAt &&
          other.createdByUserId == this.createdByUserId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RentalContractsCompanion extends UpdateCompanion<RentalContractRow> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<int> trailerId;
  final Value<DateTime> startAt;
  final Value<DateTime> endAt;
  final Value<String> pickupLocation;
  final Value<String> returnLocation;
  final Value<int> priceCents;
  final Value<ContractStatus> status;
  final Value<DateTime?> handedOverAt;
  final Value<DateTime?> returnedAt;
  final Value<int> createdByUserId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RentalContractsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.trailerId = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.pickupLocation = const Value.absent(),
    this.returnLocation = const Value.absent(),
    this.priceCents = const Value.absent(),
    this.status = const Value.absent(),
    this.handedOverAt = const Value.absent(),
    this.returnedAt = const Value.absent(),
    this.createdByUserId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RentalContractsCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required int trailerId,
    required DateTime startAt,
    required DateTime endAt,
    required String pickupLocation,
    required String returnLocation,
    required int priceCents,
    required ContractStatus status,
    this.handedOverAt = const Value.absent(),
    this.returnedAt = const Value.absent(),
    required int createdByUserId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : customerId = Value(customerId),
       trailerId = Value(trailerId),
       startAt = Value(startAt),
       endAt = Value(endAt),
       pickupLocation = Value(pickupLocation),
       returnLocation = Value(returnLocation),
       priceCents = Value(priceCents),
       status = Value(status),
       createdByUserId = Value(createdByUserId);
  static Insertable<RentalContractRow> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<int>? trailerId,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
    Expression<String>? pickupLocation,
    Expression<String>? returnLocation,
    Expression<int>? priceCents,
    Expression<String>? status,
    Expression<DateTime>? handedOverAt,
    Expression<DateTime>? returnedAt,
    Expression<int>? createdByUserId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (trailerId != null) 'trailer_id': trailerId,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (pickupLocation != null) 'pickup_location': pickupLocation,
      if (returnLocation != null) 'return_location': returnLocation,
      if (priceCents != null) 'price_cents': priceCents,
      if (status != null) 'status': status,
      if (handedOverAt != null) 'handed_over_at': handedOverAt,
      if (returnedAt != null) 'returned_at': returnedAt,
      if (createdByUserId != null) 'created_by_user_id': createdByUserId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RentalContractsCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<int>? trailerId,
    Value<DateTime>? startAt,
    Value<DateTime>? endAt,
    Value<String>? pickupLocation,
    Value<String>? returnLocation,
    Value<int>? priceCents,
    Value<ContractStatus>? status,
    Value<DateTime?>? handedOverAt,
    Value<DateTime?>? returnedAt,
    Value<int>? createdByUserId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RentalContractsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      trailerId: trailerId ?? this.trailerId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      returnLocation: returnLocation ?? this.returnLocation,
      priceCents: priceCents ?? this.priceCents,
      status: status ?? this.status,
      handedOverAt: handedOverAt ?? this.handedOverAt,
      returnedAt: returnedAt ?? this.returnedAt,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (trailerId.present) {
      map['trailer_id'] = Variable<int>(trailerId.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<DateTime>(endAt.value);
    }
    if (pickupLocation.present) {
      map['pickup_location'] = Variable<String>(pickupLocation.value);
    }
    if (returnLocation.present) {
      map['return_location'] = Variable<String>(returnLocation.value);
    }
    if (priceCents.present) {
      map['price_cents'] = Variable<int>(priceCents.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $RentalContractsTable.$converterstatus.toSql(status.value),
      );
    }
    if (handedOverAt.present) {
      map['handed_over_at'] = Variable<DateTime>(handedOverAt.value);
    }
    if (returnedAt.present) {
      map['returned_at'] = Variable<DateTime>(returnedAt.value);
    }
    if (createdByUserId.present) {
      map['created_by_user_id'] = Variable<int>(createdByUserId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RentalContractsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('trailerId: $trailerId, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('pickupLocation: $pickupLocation, ')
          ..write('returnLocation: $returnLocation, ')
          ..write('priceCents: $priceCents, ')
          ..write('status: $status, ')
          ..write('handedOverAt: $handedOverAt, ')
          ..write('returnedAt: $returnedAt, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TrailerStatusChangesTable extends TrailerStatusChanges
    with TableInfo<$TrailerStatusChangesTable, TrailerStatusChangeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrailerStatusChangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _trailerIdMeta = const VerificationMeta(
    'trailerId',
  );
  @override
  late final GeneratedColumn<int> trailerId = GeneratedColumn<int>(
    'trailer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trailer (id) ON DELETE RESTRICT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TrailerStatus?, String>
  oldStatus =
      GeneratedColumn<String>(
        'old_status',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<TrailerStatus?>(
        $TrailerStatusChangesTable.$converteroldStatusn,
      );
  @override
  late final GeneratedColumnWithTypeConverter<TrailerStatus, String> newStatus =
      GeneratedColumn<String>(
        'new_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TrailerStatus>(
        $TrailerStatusChangesTable.$converternewStatus,
      );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _changedByUserIdMeta = const VerificationMeta(
    'changedByUserId',
  );
  @override
  late final GeneratedColumn<int> changedByUserId = GeneratedColumn<int>(
    'changed_by_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_user (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _rentalContractIdMeta = const VerificationMeta(
    'rentalContractId',
  );
  @override
  late final GeneratedColumn<int> rentalContractId = GeneratedColumn<int>(
    'rental_contract_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rental_contract (id) ON DELETE RESTRICT',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trailerId,
    oldStatus,
    newStatus,
    changedAt,
    changedByUserId,
    rentalContractId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trailer_status_change';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrailerStatusChangeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trailer_id')) {
      context.handle(
        _trailerIdMeta,
        trailerId.isAcceptableOrUnknown(data['trailer_id']!, _trailerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trailerIdMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    }
    if (data.containsKey('changed_by_user_id')) {
      context.handle(
        _changedByUserIdMeta,
        changedByUserId.isAcceptableOrUnknown(
          data['changed_by_user_id']!,
          _changedByUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_changedByUserIdMeta);
    }
    if (data.containsKey('rental_contract_id')) {
      context.handle(
        _rentalContractIdMeta,
        rentalContractId.isAcceptableOrUnknown(
          data['rental_contract_id']!,
          _rentalContractIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrailerStatusChangeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrailerStatusChangeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      trailerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trailer_id'],
      )!,
      oldStatus: $TrailerStatusChangesTable.$converteroldStatusn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}old_status'],
        ),
      ),
      newStatus: $TrailerStatusChangesTable.$converternewStatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}new_status'],
        )!,
      ),
      changedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}changed_at'],
      )!,
      changedByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}changed_by_user_id'],
      )!,
      rentalContractId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rental_contract_id'],
      ),
    );
  }

  @override
  $TrailerStatusChangesTable createAlias(String alias) {
    return $TrailerStatusChangesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TrailerStatus, String, String> $converteroldStatus =
      const EnumNameConverter<TrailerStatus>(TrailerStatus.values);
  static JsonTypeConverter2<TrailerStatus?, String?, String?>
  $converteroldStatusn = JsonTypeConverter2.asNullable($converteroldStatus);
  static JsonTypeConverter2<TrailerStatus, String, String> $converternewStatus =
      const EnumNameConverter<TrailerStatus>(TrailerStatus.values);
}

class TrailerStatusChangeRow extends DataClass
    implements Insertable<TrailerStatusChangeRow> {
  final int id;
  final int trailerId;
  final TrailerStatus? oldStatus;
  final TrailerStatus newStatus;
  final DateTime changedAt;
  final int changedByUserId;
  final int? rentalContractId;
  const TrailerStatusChangeRow({
    required this.id,
    required this.trailerId,
    this.oldStatus,
    required this.newStatus,
    required this.changedAt,
    required this.changedByUserId,
    this.rentalContractId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trailer_id'] = Variable<int>(trailerId);
    if (!nullToAbsent || oldStatus != null) {
      map['old_status'] = Variable<String>(
        $TrailerStatusChangesTable.$converteroldStatusn.toSql(oldStatus),
      );
    }
    {
      map['new_status'] = Variable<String>(
        $TrailerStatusChangesTable.$converternewStatus.toSql(newStatus),
      );
    }
    map['changed_at'] = Variable<DateTime>(changedAt);
    map['changed_by_user_id'] = Variable<int>(changedByUserId);
    if (!nullToAbsent || rentalContractId != null) {
      map['rental_contract_id'] = Variable<int>(rentalContractId);
    }
    return map;
  }

  TrailerStatusChangesCompanion toCompanion(bool nullToAbsent) {
    return TrailerStatusChangesCompanion(
      id: Value(id),
      trailerId: Value(trailerId),
      oldStatus: oldStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(oldStatus),
      newStatus: Value(newStatus),
      changedAt: Value(changedAt),
      changedByUserId: Value(changedByUserId),
      rentalContractId: rentalContractId == null && nullToAbsent
          ? const Value.absent()
          : Value(rentalContractId),
    );
  }

  factory TrailerStatusChangeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrailerStatusChangeRow(
      id: serializer.fromJson<int>(json['id']),
      trailerId: serializer.fromJson<int>(json['trailerId']),
      oldStatus: $TrailerStatusChangesTable.$converteroldStatusn.fromJson(
        serializer.fromJson<String?>(json['oldStatus']),
      ),
      newStatus: $TrailerStatusChangesTable.$converternewStatus.fromJson(
        serializer.fromJson<String>(json['newStatus']),
      ),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
      changedByUserId: serializer.fromJson<int>(json['changedByUserId']),
      rentalContractId: serializer.fromJson<int?>(json['rentalContractId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trailerId': serializer.toJson<int>(trailerId),
      'oldStatus': serializer.toJson<String?>(
        $TrailerStatusChangesTable.$converteroldStatusn.toJson(oldStatus),
      ),
      'newStatus': serializer.toJson<String>(
        $TrailerStatusChangesTable.$converternewStatus.toJson(newStatus),
      ),
      'changedAt': serializer.toJson<DateTime>(changedAt),
      'changedByUserId': serializer.toJson<int>(changedByUserId),
      'rentalContractId': serializer.toJson<int?>(rentalContractId),
    };
  }

  TrailerStatusChangeRow copyWith({
    int? id,
    int? trailerId,
    Value<TrailerStatus?> oldStatus = const Value.absent(),
    TrailerStatus? newStatus,
    DateTime? changedAt,
    int? changedByUserId,
    Value<int?> rentalContractId = const Value.absent(),
  }) => TrailerStatusChangeRow(
    id: id ?? this.id,
    trailerId: trailerId ?? this.trailerId,
    oldStatus: oldStatus.present ? oldStatus.value : this.oldStatus,
    newStatus: newStatus ?? this.newStatus,
    changedAt: changedAt ?? this.changedAt,
    changedByUserId: changedByUserId ?? this.changedByUserId,
    rentalContractId: rentalContractId.present
        ? rentalContractId.value
        : this.rentalContractId,
  );
  TrailerStatusChangeRow copyWithCompanion(TrailerStatusChangesCompanion data) {
    return TrailerStatusChangeRow(
      id: data.id.present ? data.id.value : this.id,
      trailerId: data.trailerId.present ? data.trailerId.value : this.trailerId,
      oldStatus: data.oldStatus.present ? data.oldStatus.value : this.oldStatus,
      newStatus: data.newStatus.present ? data.newStatus.value : this.newStatus,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      changedByUserId: data.changedByUserId.present
          ? data.changedByUserId.value
          : this.changedByUserId,
      rentalContractId: data.rentalContractId.present
          ? data.rentalContractId.value
          : this.rentalContractId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrailerStatusChangeRow(')
          ..write('id: $id, ')
          ..write('trailerId: $trailerId, ')
          ..write('oldStatus: $oldStatus, ')
          ..write('newStatus: $newStatus, ')
          ..write('changedAt: $changedAt, ')
          ..write('changedByUserId: $changedByUserId, ')
          ..write('rentalContractId: $rentalContractId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    trailerId,
    oldStatus,
    newStatus,
    changedAt,
    changedByUserId,
    rentalContractId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrailerStatusChangeRow &&
          other.id == this.id &&
          other.trailerId == this.trailerId &&
          other.oldStatus == this.oldStatus &&
          other.newStatus == this.newStatus &&
          other.changedAt == this.changedAt &&
          other.changedByUserId == this.changedByUserId &&
          other.rentalContractId == this.rentalContractId);
}

class TrailerStatusChangesCompanion
    extends UpdateCompanion<TrailerStatusChangeRow> {
  final Value<int> id;
  final Value<int> trailerId;
  final Value<TrailerStatus?> oldStatus;
  final Value<TrailerStatus> newStatus;
  final Value<DateTime> changedAt;
  final Value<int> changedByUserId;
  final Value<int?> rentalContractId;
  const TrailerStatusChangesCompanion({
    this.id = const Value.absent(),
    this.trailerId = const Value.absent(),
    this.oldStatus = const Value.absent(),
    this.newStatus = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.changedByUserId = const Value.absent(),
    this.rentalContractId = const Value.absent(),
  });
  TrailerStatusChangesCompanion.insert({
    this.id = const Value.absent(),
    required int trailerId,
    this.oldStatus = const Value.absent(),
    required TrailerStatus newStatus,
    this.changedAt = const Value.absent(),
    required int changedByUserId,
    this.rentalContractId = const Value.absent(),
  }) : trailerId = Value(trailerId),
       newStatus = Value(newStatus),
       changedByUserId = Value(changedByUserId);
  static Insertable<TrailerStatusChangeRow> custom({
    Expression<int>? id,
    Expression<int>? trailerId,
    Expression<String>? oldStatus,
    Expression<String>? newStatus,
    Expression<DateTime>? changedAt,
    Expression<int>? changedByUserId,
    Expression<int>? rentalContractId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trailerId != null) 'trailer_id': trailerId,
      if (oldStatus != null) 'old_status': oldStatus,
      if (newStatus != null) 'new_status': newStatus,
      if (changedAt != null) 'changed_at': changedAt,
      if (changedByUserId != null) 'changed_by_user_id': changedByUserId,
      if (rentalContractId != null) 'rental_contract_id': rentalContractId,
    });
  }

  TrailerStatusChangesCompanion copyWith({
    Value<int>? id,
    Value<int>? trailerId,
    Value<TrailerStatus?>? oldStatus,
    Value<TrailerStatus>? newStatus,
    Value<DateTime>? changedAt,
    Value<int>? changedByUserId,
    Value<int?>? rentalContractId,
  }) {
    return TrailerStatusChangesCompanion(
      id: id ?? this.id,
      trailerId: trailerId ?? this.trailerId,
      oldStatus: oldStatus ?? this.oldStatus,
      newStatus: newStatus ?? this.newStatus,
      changedAt: changedAt ?? this.changedAt,
      changedByUserId: changedByUserId ?? this.changedByUserId,
      rentalContractId: rentalContractId ?? this.rentalContractId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trailerId.present) {
      map['trailer_id'] = Variable<int>(trailerId.value);
    }
    if (oldStatus.present) {
      map['old_status'] = Variable<String>(
        $TrailerStatusChangesTable.$converteroldStatusn.toSql(oldStatus.value),
      );
    }
    if (newStatus.present) {
      map['new_status'] = Variable<String>(
        $TrailerStatusChangesTable.$converternewStatus.toSql(newStatus.value),
      );
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (changedByUserId.present) {
      map['changed_by_user_id'] = Variable<int>(changedByUserId.value);
    }
    if (rentalContractId.present) {
      map['rental_contract_id'] = Variable<int>(rentalContractId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrailerStatusChangesCompanion(')
          ..write('id: $id, ')
          ..write('trailerId: $trailerId, ')
          ..write('oldStatus: $oldStatus, ')
          ..write('newStatus: $newStatus, ')
          ..write('changedAt: $changedAt, ')
          ..write('changedByUserId: $changedByUserId, ')
          ..write('rentalContractId: $rentalContractId')
          ..write(')'))
        .toString();
  }
}

class $DamageRecordsTable extends DamageRecords
    with TableInfo<$DamageRecordsTable, DamageRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DamageRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _trailerIdMeta = const VerificationMeta(
    'trailerId',
  );
  @override
  late final GeneratedColumn<int> trailerId = GeneratedColumn<int>(
    'trailer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trailer (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _eventDateMeta = const VerificationMeta(
    'eventDate',
  );
  @override
  late final GeneratedColumn<DateTime> eventDate = GeneratedColumn<DateTime>(
    'event_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DamageType, String> damageType =
      GeneratedColumn<String>(
        'damage_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DamageType>($DamageRecordsTable.$converterdamageType);
  @override
  late final GeneratedColumnWithTypeConverter<DamageCause, String> causedBy =
      GeneratedColumn<String>(
        'caused_by',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DamageCause>($DamageRecordsTable.$convertercausedBy);
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customer (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _rentalContractIdMeta = const VerificationMeta(
    'rentalContractId',
  );
  @override
  late final GeneratedColumn<int> rentalContractId = GeneratedColumn<int>(
    'rental_contract_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rental_contract (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _costCentsMeta = const VerificationMeta(
    'costCents',
  );
  @override
  late final GeneratedColumn<int> costCents = GeneratedColumn<int>(
    'cost_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByUserIdMeta = const VerificationMeta(
    'createdByUserId',
  );
  @override
  late final GeneratedColumn<int> createdByUserId = GeneratedColumn<int>(
    'created_by_user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES app_user (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trailerId,
    eventDate,
    description,
    damageType,
    causedBy,
    customerId,
    rentalContractId,
    costCents,
    createdByUserId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'damage_record';
  @override
  VerificationContext validateIntegrity(
    Insertable<DamageRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trailer_id')) {
      context.handle(
        _trailerIdMeta,
        trailerId.isAcceptableOrUnknown(data['trailer_id']!, _trailerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trailerIdMeta);
    }
    if (data.containsKey('event_date')) {
      context.handle(
        _eventDateMeta,
        eventDate.isAcceptableOrUnknown(data['event_date']!, _eventDateMeta),
      );
    } else if (isInserting) {
      context.missing(_eventDateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('rental_contract_id')) {
      context.handle(
        _rentalContractIdMeta,
        rentalContractId.isAcceptableOrUnknown(
          data['rental_contract_id']!,
          _rentalContractIdMeta,
        ),
      );
    }
    if (data.containsKey('cost_cents')) {
      context.handle(
        _costCentsMeta,
        costCents.isAcceptableOrUnknown(data['cost_cents']!, _costCentsMeta),
      );
    }
    if (data.containsKey('created_by_user_id')) {
      context.handle(
        _createdByUserIdMeta,
        createdByUserId.isAcceptableOrUnknown(
          data['created_by_user_id']!,
          _createdByUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdByUserIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DamageRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DamageRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      trailerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trailer_id'],
      )!,
      eventDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}event_date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      damageType: $DamageRecordsTable.$converterdamageType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}damage_type'],
        )!,
      ),
      causedBy: $DamageRecordsTable.$convertercausedBy.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}caused_by'],
        )!,
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      rentalContractId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rental_contract_id'],
      ),
      costCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_cents'],
      ),
      createdByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_by_user_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DamageRecordsTable createAlias(String alias) {
    return $DamageRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DamageType, String, String> $converterdamageType =
      const EnumNameConverter<DamageType>(DamageType.values);
  static JsonTypeConverter2<DamageCause, String, String> $convertercausedBy =
      const EnumNameConverter<DamageCause>(DamageCause.values);
}

class DamageRecordRow extends DataClass implements Insertable<DamageRecordRow> {
  final int id;
  final int trailerId;
  final DateTime eventDate;
  final String description;
  final DamageType damageType;
  final DamageCause causedBy;
  final int? customerId;
  final int? rentalContractId;
  final int? costCents;
  final int createdByUserId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DamageRecordRow({
    required this.id,
    required this.trailerId,
    required this.eventDate,
    required this.description,
    required this.damageType,
    required this.causedBy,
    this.customerId,
    this.rentalContractId,
    this.costCents,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trailer_id'] = Variable<int>(trailerId);
    map['event_date'] = Variable<DateTime>(eventDate);
    map['description'] = Variable<String>(description);
    {
      map['damage_type'] = Variable<String>(
        $DamageRecordsTable.$converterdamageType.toSql(damageType),
      );
    }
    {
      map['caused_by'] = Variable<String>(
        $DamageRecordsTable.$convertercausedBy.toSql(causedBy),
      );
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || rentalContractId != null) {
      map['rental_contract_id'] = Variable<int>(rentalContractId);
    }
    if (!nullToAbsent || costCents != null) {
      map['cost_cents'] = Variable<int>(costCents);
    }
    map['created_by_user_id'] = Variable<int>(createdByUserId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DamageRecordsCompanion toCompanion(bool nullToAbsent) {
    return DamageRecordsCompanion(
      id: Value(id),
      trailerId: Value(trailerId),
      eventDate: Value(eventDate),
      description: Value(description),
      damageType: Value(damageType),
      causedBy: Value(causedBy),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      rentalContractId: rentalContractId == null && nullToAbsent
          ? const Value.absent()
          : Value(rentalContractId),
      costCents: costCents == null && nullToAbsent
          ? const Value.absent()
          : Value(costCents),
      createdByUserId: Value(createdByUserId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DamageRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DamageRecordRow(
      id: serializer.fromJson<int>(json['id']),
      trailerId: serializer.fromJson<int>(json['trailerId']),
      eventDate: serializer.fromJson<DateTime>(json['eventDate']),
      description: serializer.fromJson<String>(json['description']),
      damageType: $DamageRecordsTable.$converterdamageType.fromJson(
        serializer.fromJson<String>(json['damageType']),
      ),
      causedBy: $DamageRecordsTable.$convertercausedBy.fromJson(
        serializer.fromJson<String>(json['causedBy']),
      ),
      customerId: serializer.fromJson<int?>(json['customerId']),
      rentalContractId: serializer.fromJson<int?>(json['rentalContractId']),
      costCents: serializer.fromJson<int?>(json['costCents']),
      createdByUserId: serializer.fromJson<int>(json['createdByUserId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trailerId': serializer.toJson<int>(trailerId),
      'eventDate': serializer.toJson<DateTime>(eventDate),
      'description': serializer.toJson<String>(description),
      'damageType': serializer.toJson<String>(
        $DamageRecordsTable.$converterdamageType.toJson(damageType),
      ),
      'causedBy': serializer.toJson<String>(
        $DamageRecordsTable.$convertercausedBy.toJson(causedBy),
      ),
      'customerId': serializer.toJson<int?>(customerId),
      'rentalContractId': serializer.toJson<int?>(rentalContractId),
      'costCents': serializer.toJson<int?>(costCents),
      'createdByUserId': serializer.toJson<int>(createdByUserId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DamageRecordRow copyWith({
    int? id,
    int? trailerId,
    DateTime? eventDate,
    String? description,
    DamageType? damageType,
    DamageCause? causedBy,
    Value<int?> customerId = const Value.absent(),
    Value<int?> rentalContractId = const Value.absent(),
    Value<int?> costCents = const Value.absent(),
    int? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DamageRecordRow(
    id: id ?? this.id,
    trailerId: trailerId ?? this.trailerId,
    eventDate: eventDate ?? this.eventDate,
    description: description ?? this.description,
    damageType: damageType ?? this.damageType,
    causedBy: causedBy ?? this.causedBy,
    customerId: customerId.present ? customerId.value : this.customerId,
    rentalContractId: rentalContractId.present
        ? rentalContractId.value
        : this.rentalContractId,
    costCents: costCents.present ? costCents.value : this.costCents,
    createdByUserId: createdByUserId ?? this.createdByUserId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DamageRecordRow copyWithCompanion(DamageRecordsCompanion data) {
    return DamageRecordRow(
      id: data.id.present ? data.id.value : this.id,
      trailerId: data.trailerId.present ? data.trailerId.value : this.trailerId,
      eventDate: data.eventDate.present ? data.eventDate.value : this.eventDate,
      description: data.description.present
          ? data.description.value
          : this.description,
      damageType: data.damageType.present
          ? data.damageType.value
          : this.damageType,
      causedBy: data.causedBy.present ? data.causedBy.value : this.causedBy,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      rentalContractId: data.rentalContractId.present
          ? data.rentalContractId.value
          : this.rentalContractId,
      costCents: data.costCents.present ? data.costCents.value : this.costCents,
      createdByUserId: data.createdByUserId.present
          ? data.createdByUserId.value
          : this.createdByUserId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DamageRecordRow(')
          ..write('id: $id, ')
          ..write('trailerId: $trailerId, ')
          ..write('eventDate: $eventDate, ')
          ..write('description: $description, ')
          ..write('damageType: $damageType, ')
          ..write('causedBy: $causedBy, ')
          ..write('customerId: $customerId, ')
          ..write('rentalContractId: $rentalContractId, ')
          ..write('costCents: $costCents, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    trailerId,
    eventDate,
    description,
    damageType,
    causedBy,
    customerId,
    rentalContractId,
    costCents,
    createdByUserId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DamageRecordRow &&
          other.id == this.id &&
          other.trailerId == this.trailerId &&
          other.eventDate == this.eventDate &&
          other.description == this.description &&
          other.damageType == this.damageType &&
          other.causedBy == this.causedBy &&
          other.customerId == this.customerId &&
          other.rentalContractId == this.rentalContractId &&
          other.costCents == this.costCents &&
          other.createdByUserId == this.createdByUserId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DamageRecordsCompanion extends UpdateCompanion<DamageRecordRow> {
  final Value<int> id;
  final Value<int> trailerId;
  final Value<DateTime> eventDate;
  final Value<String> description;
  final Value<DamageType> damageType;
  final Value<DamageCause> causedBy;
  final Value<int?> customerId;
  final Value<int?> rentalContractId;
  final Value<int?> costCents;
  final Value<int> createdByUserId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DamageRecordsCompanion({
    this.id = const Value.absent(),
    this.trailerId = const Value.absent(),
    this.eventDate = const Value.absent(),
    this.description = const Value.absent(),
    this.damageType = const Value.absent(),
    this.causedBy = const Value.absent(),
    this.customerId = const Value.absent(),
    this.rentalContractId = const Value.absent(),
    this.costCents = const Value.absent(),
    this.createdByUserId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DamageRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int trailerId,
    required DateTime eventDate,
    required String description,
    required DamageType damageType,
    required DamageCause causedBy,
    this.customerId = const Value.absent(),
    this.rentalContractId = const Value.absent(),
    this.costCents = const Value.absent(),
    required int createdByUserId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : trailerId = Value(trailerId),
       eventDate = Value(eventDate),
       description = Value(description),
       damageType = Value(damageType),
       causedBy = Value(causedBy),
       createdByUserId = Value(createdByUserId);
  static Insertable<DamageRecordRow> custom({
    Expression<int>? id,
    Expression<int>? trailerId,
    Expression<DateTime>? eventDate,
    Expression<String>? description,
    Expression<String>? damageType,
    Expression<String>? causedBy,
    Expression<int>? customerId,
    Expression<int>? rentalContractId,
    Expression<int>? costCents,
    Expression<int>? createdByUserId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trailerId != null) 'trailer_id': trailerId,
      if (eventDate != null) 'event_date': eventDate,
      if (description != null) 'description': description,
      if (damageType != null) 'damage_type': damageType,
      if (causedBy != null) 'caused_by': causedBy,
      if (customerId != null) 'customer_id': customerId,
      if (rentalContractId != null) 'rental_contract_id': rentalContractId,
      if (costCents != null) 'cost_cents': costCents,
      if (createdByUserId != null) 'created_by_user_id': createdByUserId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DamageRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? trailerId,
    Value<DateTime>? eventDate,
    Value<String>? description,
    Value<DamageType>? damageType,
    Value<DamageCause>? causedBy,
    Value<int?>? customerId,
    Value<int?>? rentalContractId,
    Value<int?>? costCents,
    Value<int>? createdByUserId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return DamageRecordsCompanion(
      id: id ?? this.id,
      trailerId: trailerId ?? this.trailerId,
      eventDate: eventDate ?? this.eventDate,
      description: description ?? this.description,
      damageType: damageType ?? this.damageType,
      causedBy: causedBy ?? this.causedBy,
      customerId: customerId ?? this.customerId,
      rentalContractId: rentalContractId ?? this.rentalContractId,
      costCents: costCents ?? this.costCents,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trailerId.present) {
      map['trailer_id'] = Variable<int>(trailerId.value);
    }
    if (eventDate.present) {
      map['event_date'] = Variable<DateTime>(eventDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (damageType.present) {
      map['damage_type'] = Variable<String>(
        $DamageRecordsTable.$converterdamageType.toSql(damageType.value),
      );
    }
    if (causedBy.present) {
      map['caused_by'] = Variable<String>(
        $DamageRecordsTable.$convertercausedBy.toSql(causedBy.value),
      );
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (rentalContractId.present) {
      map['rental_contract_id'] = Variable<int>(rentalContractId.value);
    }
    if (costCents.present) {
      map['cost_cents'] = Variable<int>(costCents.value);
    }
    if (createdByUserId.present) {
      map['created_by_user_id'] = Variable<int>(createdByUserId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DamageRecordsCompanion(')
          ..write('id: $id, ')
          ..write('trailerId: $trailerId, ')
          ..write('eventDate: $eventDate, ')
          ..write('description: $description, ')
          ..write('damageType: $damageType, ')
          ..write('causedBy: $causedBy, ')
          ..write('customerId: $customerId, ')
          ..write('rentalContractId: $rentalContractId, ')
          ..write('costCents: $costCents, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PhotosTable extends Photos with TableInfo<$PhotosTable, PhotoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _trailerIdMeta = const VerificationMeta(
    'trailerId',
  );
  @override
  late final GeneratedColumn<int> trailerId = GeneratedColumn<int>(
    'trailer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trailer (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _damageRecordIdMeta = const VerificationMeta(
    'damageRecordId',
  );
  @override
  late final GeneratedColumn<int> damageRecordId = GeneratedColumn<int>(
    'damage_record_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES damage_record (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trailerId,
    damageRecordId,
    filePath,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhotoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trailer_id')) {
      context.handle(
        _trailerIdMeta,
        trailerId.isAcceptableOrUnknown(data['trailer_id']!, _trailerIdMeta),
      );
    }
    if (data.containsKey('damage_record_id')) {
      context.handle(
        _damageRecordIdMeta,
        damageRecordId.isAcceptableOrUnknown(
          data['damage_record_id']!,
          _damageRecordIdMeta,
        ),
      );
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhotoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      trailerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trailer_id'],
      ),
      damageRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}damage_record_id'],
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PhotosTable createAlias(String alias) {
    return $PhotosTable(attachedDatabase, alias);
  }
}

class PhotoRow extends DataClass implements Insertable<PhotoRow> {
  final int id;
  final int? trailerId;
  final int? damageRecordId;
  final String filePath;
  final int sortOrder;
  final DateTime createdAt;
  const PhotoRow({
    required this.id,
    this.trailerId,
    this.damageRecordId,
    required this.filePath,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || trailerId != null) {
      map['trailer_id'] = Variable<int>(trailerId);
    }
    if (!nullToAbsent || damageRecordId != null) {
      map['damage_record_id'] = Variable<int>(damageRecordId);
    }
    map['file_path'] = Variable<String>(filePath);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PhotosCompanion toCompanion(bool nullToAbsent) {
    return PhotosCompanion(
      id: Value(id),
      trailerId: trailerId == null && nullToAbsent
          ? const Value.absent()
          : Value(trailerId),
      damageRecordId: damageRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(damageRecordId),
      filePath: Value(filePath),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory PhotoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoRow(
      id: serializer.fromJson<int>(json['id']),
      trailerId: serializer.fromJson<int?>(json['trailerId']),
      damageRecordId: serializer.fromJson<int?>(json['damageRecordId']),
      filePath: serializer.fromJson<String>(json['filePath']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trailerId': serializer.toJson<int?>(trailerId),
      'damageRecordId': serializer.toJson<int?>(damageRecordId),
      'filePath': serializer.toJson<String>(filePath),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PhotoRow copyWith({
    int? id,
    Value<int?> trailerId = const Value.absent(),
    Value<int?> damageRecordId = const Value.absent(),
    String? filePath,
    int? sortOrder,
    DateTime? createdAt,
  }) => PhotoRow(
    id: id ?? this.id,
    trailerId: trailerId.present ? trailerId.value : this.trailerId,
    damageRecordId: damageRecordId.present
        ? damageRecordId.value
        : this.damageRecordId,
    filePath: filePath ?? this.filePath,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  PhotoRow copyWithCompanion(PhotosCompanion data) {
    return PhotoRow(
      id: data.id.present ? data.id.value : this.id,
      trailerId: data.trailerId.present ? data.trailerId.value : this.trailerId,
      damageRecordId: data.damageRecordId.present
          ? data.damageRecordId.value
          : this.damageRecordId,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoRow(')
          ..write('id: $id, ')
          ..write('trailerId: $trailerId, ')
          ..write('damageRecordId: $damageRecordId, ')
          ..write('filePath: $filePath, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    trailerId,
    damageRecordId,
    filePath,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoRow &&
          other.id == this.id &&
          other.trailerId == this.trailerId &&
          other.damageRecordId == this.damageRecordId &&
          other.filePath == this.filePath &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class PhotosCompanion extends UpdateCompanion<PhotoRow> {
  final Value<int> id;
  final Value<int?> trailerId;
  final Value<int?> damageRecordId;
  final Value<String> filePath;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  const PhotosCompanion({
    this.id = const Value.absent(),
    this.trailerId = const Value.absent(),
    this.damageRecordId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PhotosCompanion.insert({
    this.id = const Value.absent(),
    this.trailerId = const Value.absent(),
    this.damageRecordId = const Value.absent(),
    required String filePath,
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : filePath = Value(filePath);
  static Insertable<PhotoRow> custom({
    Expression<int>? id,
    Expression<int>? trailerId,
    Expression<int>? damageRecordId,
    Expression<String>? filePath,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trailerId != null) 'trailer_id': trailerId,
      if (damageRecordId != null) 'damage_record_id': damageRecordId,
      if (filePath != null) 'file_path': filePath,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PhotosCompanion copyWith({
    Value<int>? id,
    Value<int?>? trailerId,
    Value<int?>? damageRecordId,
    Value<String>? filePath,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
  }) {
    return PhotosCompanion(
      id: id ?? this.id,
      trailerId: trailerId ?? this.trailerId,
      damageRecordId: damageRecordId ?? this.damageRecordId,
      filePath: filePath ?? this.filePath,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trailerId.present) {
      map['trailer_id'] = Variable<int>(trailerId.value);
    }
    if (damageRecordId.present) {
      map['damage_record_id'] = Variable<int>(damageRecordId.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotosCompanion(')
          ..write('id: $id, ')
          ..write('trailerId: $trailerId, ')
          ..write('damageRecordId: $damageRecordId, ')
          ..write('filePath: $filePath, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppUsersTable appUsers = $AppUsersTable(this);
  late final $TrailerTypesTable trailerTypes = $TrailerTypesTable(this);
  late final $TrailersTable trailers = $TrailersTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $RentalContractsTable rentalContracts = $RentalContractsTable(
    this,
  );
  late final $TrailerStatusChangesTable trailerStatusChanges =
      $TrailerStatusChangesTable(this);
  late final $DamageRecordsTable damageRecords = $DamageRecordsTable(this);
  late final $PhotosTable photos = $PhotosTable(this);
  late final Index trailerStatusIdx = Index(
    'trailer_status_idx',
    'CREATE INDEX trailer_status_idx ON trailer (status)',
  );
  late final Index trailerStatusChangeTrailerIdx = Index(
    'trailer_status_change_trailer_idx',
    'CREATE INDEX trailer_status_change_trailer_idx ON trailer_status_change (trailer_id, changed_at)',
  );
  late final Index rentalContractTrailerIdx = Index(
    'rental_contract_trailer_idx',
    'CREATE INDEX rental_contract_trailer_idx ON rental_contract (trailer_id, start_at)',
  );
  late final Index rentalContractCustomerIdx = Index(
    'rental_contract_customer_idx',
    'CREATE INDEX rental_contract_customer_idx ON rental_contract (customer_id)',
  );
  late final Index rentalContractStatusIdx = Index(
    'rental_contract_status_idx',
    'CREATE INDEX rental_contract_status_idx ON rental_contract (status, start_at)',
  );
  late final Index damageRecordTrailerIdx = Index(
    'damage_record_trailer_idx',
    'CREATE INDEX damage_record_trailer_idx ON damage_record (trailer_id, event_date)',
  );
  late final Index photoTrailerIdx = Index(
    'photo_trailer_idx',
    'CREATE INDEX photo_trailer_idx ON photo (trailer_id)',
  );
  late final Index photoDamageRecordIdx = Index(
    'photo_damage_record_idx',
    'CREATE INDEX photo_damage_record_idx ON photo (damage_record_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appUsers,
    trailerTypes,
    trailers,
    customers,
    rentalContracts,
    trailerStatusChanges,
    damageRecords,
    photos,
    trailerStatusIdx,
    trailerStatusChangeTrailerIdx,
    rentalContractTrailerIdx,
    rentalContractCustomerIdx,
    rentalContractStatusIdx,
    damageRecordTrailerIdx,
    photoTrailerIdx,
    photoDamageRecordIdx,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'damage_record',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('photo', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AppUsersTableCreateCompanionBuilder =
    AppUsersCompanion Function({
      Value<int> id,
      required String name,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$AppUsersTableUpdateCompanionBuilder =
    AppUsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$AppUsersTableReferences
    extends BaseReferences<_$AppDatabase, $AppUsersTable, AppUserRow> {
  $$AppUsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RentalContractsTable, List<RentalContractRow>>
  _rentalContractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rentalContracts,
    aliasName: 'app_user__id__rental_contract__created_by_user_id',
  );

  $$RentalContractsTableProcessedTableManager get rentalContractsRefs {
    final manager = $$RentalContractsTableTableManager(
      $_db,
      $_db.rentalContracts,
    ).filter((f) => f.createdByUserId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _rentalContractsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TrailerStatusChangesTable,
    List<TrailerStatusChangeRow>
  >
  _trailerStatusChangesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.trailerStatusChanges,
        aliasName: 'app_user__id__trailer_status_change__changed_by_user_id',
      );

  $$TrailerStatusChangesTableProcessedTableManager
  get trailerStatusChangesRefs {
    final manager = $$TrailerStatusChangesTableTableManager(
      $_db,
      $_db.trailerStatusChanges,
    ).filter((f) => f.changedByUserId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _trailerStatusChangesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DamageRecordsTable, List<DamageRecordRow>>
  _damageRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.damageRecords,
    aliasName: 'app_user__id__damage_record__created_by_user_id',
  );

  $$DamageRecordsTableProcessedTableManager get damageRecordsRefs {
    final manager = $$DamageRecordsTableTableManager(
      $_db,
      $_db.damageRecords,
    ).filter((f) => f.createdByUserId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_damageRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AppUsersTableFilterComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> rentalContractsRefs(
    Expression<bool> Function($$RentalContractsTableFilterComposer f) f,
  ) {
    final $$RentalContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.createdByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableFilterComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> trailerStatusChangesRefs(
    Expression<bool> Function($$TrailerStatusChangesTableFilterComposer f) f,
  ) {
    final $$TrailerStatusChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trailerStatusChanges,
      getReferencedColumn: (t) => t.changedByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailerStatusChangesTableFilterComposer(
            $db: $db,
            $table: $db.trailerStatusChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> damageRecordsRefs(
    Expression<bool> Function($$DamageRecordsTableFilterComposer f) f,
  ) {
    final $$DamageRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.createdByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableFilterComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AppUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> rentalContractsRefs<T extends Object>(
    Expression<T> Function($$RentalContractsTableAnnotationComposer a) f,
  ) {
    final $$RentalContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.createdByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> trailerStatusChangesRefs<T extends Object>(
    Expression<T> Function($$TrailerStatusChangesTableAnnotationComposer a) f,
  ) {
    final $$TrailerStatusChangesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.trailerStatusChanges,
          getReferencedColumn: (t) => t.changedByUserId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TrailerStatusChangesTableAnnotationComposer(
                $db: $db,
                $table: $db.trailerStatusChanges,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> damageRecordsRefs<T extends Object>(
    Expression<T> Function($$DamageRecordsTableAnnotationComposer a) f,
  ) {
    final $$DamageRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.createdByUserId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AppUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppUsersTable,
          AppUserRow,
          $$AppUsersTableFilterComposer,
          $$AppUsersTableOrderingComposer,
          $$AppUsersTableAnnotationComposer,
          $$AppUsersTableCreateCompanionBuilder,
          $$AppUsersTableUpdateCompanionBuilder,
          (AppUserRow, $$AppUsersTableReferences),
          AppUserRow,
          PrefetchHooks Function({
            bool rentalContractsRefs,
            bool trailerStatusChangesRefs,
            bool damageRecordsRefs,
          })
        > {
  $$AppUsersTableTableManager(_$AppDatabase db, $AppUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppUsersCompanion(
                id: id,
                name: name,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppUsersCompanion.insert(
                id: id,
                name: name,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppUsersTable, AppUserRow>(table),
                  $$AppUsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                rentalContractsRefs = false,
                trailerStatusChangesRefs = false,
                damageRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (rentalContractsRefs) db.rentalContracts,
                    if (trailerStatusChangesRefs) db.trailerStatusChanges,
                    if (damageRecordsRefs) db.damageRecords,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (rentalContractsRefs)
                        await $_getPrefetchedData<
                          AppUserRow,
                          $AppUsersTable,
                          RentalContractRow
                        >(
                          currentTable: table,
                          referencedTable: $$AppUsersTableReferences
                              ._rentalContractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppUsersTableReferences(
                                db,
                                table,
                                p0,
                              ).rentalContractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.createdByUserId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (trailerStatusChangesRefs)
                        await $_getPrefetchedData<
                          AppUserRow,
                          $AppUsersTable,
                          TrailerStatusChangeRow
                        >(
                          currentTable: table,
                          referencedTable: $$AppUsersTableReferences
                              ._trailerStatusChangesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppUsersTableReferences(
                                db,
                                table,
                                p0,
                              ).trailerStatusChangesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.changedByUserId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (damageRecordsRefs)
                        await $_getPrefetchedData<
                          AppUserRow,
                          $AppUsersTable,
                          DamageRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$AppUsersTableReferences
                              ._damageRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AppUsersTableReferences(
                                db,
                                table,
                                p0,
                              ).damageRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.createdByUserId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AppUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppUsersTable,
      AppUserRow,
      $$AppUsersTableFilterComposer,
      $$AppUsersTableOrderingComposer,
      $$AppUsersTableAnnotationComposer,
      $$AppUsersTableCreateCompanionBuilder,
      $$AppUsersTableUpdateCompanionBuilder,
      (AppUserRow, $$AppUsersTableReferences),
      AppUserRow,
      PrefetchHooks Function({
        bool rentalContractsRefs,
        bool trailerStatusChangesRefs,
        bool damageRecordsRefs,
      })
    >;
typedef $$TrailerTypesTableCreateCompanionBuilder =
    TrailerTypesCompanion Function({
      Value<int> id,
      required String name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TrailerTypesTableUpdateCompanionBuilder =
    TrailerTypesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TrailerTypesTableReferences
    extends BaseReferences<_$AppDatabase, $TrailerTypesTable, TrailerTypeRow> {
  $$TrailerTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TrailersTable, List<TrailerRow>>
  _trailersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trailers,
    aliasName: 'trailer_type__id__trailer__trailer_type_id',
  );

  $$TrailersTableProcessedTableManager get trailersRefs {
    final manager = $$TrailersTableTableManager(
      $_db,
      $_db.trailers,
    ).filter((f) => f.trailerTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trailersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TrailerTypesTableFilterComposer
    extends Composer<_$AppDatabase, $TrailerTypesTable> {
  $$TrailerTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> trailersRefs(
    Expression<bool> Function($$TrailersTableFilterComposer f) f,
  ) {
    final $$TrailersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.trailerTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableFilterComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrailerTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $TrailerTypesTable> {
  $$TrailerTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrailerTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrailerTypesTable> {
  $$TrailerTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> trailersRefs<T extends Object>(
    Expression<T> Function($$TrailersTableAnnotationComposer a) f,
  ) {
    final $$TrailersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.trailerTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableAnnotationComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrailerTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrailerTypesTable,
          TrailerTypeRow,
          $$TrailerTypesTableFilterComposer,
          $$TrailerTypesTableOrderingComposer,
          $$TrailerTypesTableAnnotationComposer,
          $$TrailerTypesTableCreateCompanionBuilder,
          $$TrailerTypesTableUpdateCompanionBuilder,
          (TrailerTypeRow, $$TrailerTypesTableReferences),
          TrailerTypeRow,
          PrefetchHooks Function({bool trailersRefs})
        > {
  $$TrailerTypesTableTableManager(_$AppDatabase db, $TrailerTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrailerTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrailerTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrailerTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TrailerTypesCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TrailerTypesCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrailerTypesTable, TrailerTypeRow>(table),
                  $$TrailerTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trailersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (trailersRefs) db.trailers],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trailersRefs)
                    await $_getPrefetchedData<
                      TrailerTypeRow,
                      $TrailerTypesTable,
                      TrailerRow
                    >(
                      currentTable: table,
                      referencedTable: $$TrailerTypesTableReferences
                          ._trailersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TrailerTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).trailersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.trailerTypeId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TrailerTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrailerTypesTable,
      TrailerTypeRow,
      $$TrailerTypesTableFilterComposer,
      $$TrailerTypesTableOrderingComposer,
      $$TrailerTypesTableAnnotationComposer,
      $$TrailerTypesTableCreateCompanionBuilder,
      $$TrailerTypesTableUpdateCompanionBuilder,
      (TrailerTypeRow, $$TrailerTypesTableReferences),
      TrailerTypeRow,
      PrefetchHooks Function({bool trailersRefs})
    >;
typedef $$TrailersTableCreateCompanionBuilder =
    TrailersCompanion Function({
      Value<int> id,
      required String internalCode,
      required String licensePlate,
      required int trailerTypeId,
      required TrailerStatus status,
      Value<String?> locationAddress,
      Value<double?> locationLatitude,
      Value<double?> locationLongitude,
      Value<DateTime?> locationUpdatedAt,
      Value<DateTime?> archivedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TrailersTableUpdateCompanionBuilder =
    TrailersCompanion Function({
      Value<int> id,
      Value<String> internalCode,
      Value<String> licensePlate,
      Value<int> trailerTypeId,
      Value<TrailerStatus> status,
      Value<String?> locationAddress,
      Value<double?> locationLatitude,
      Value<double?> locationLongitude,
      Value<DateTime?> locationUpdatedAt,
      Value<DateTime?> archivedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TrailersTableReferences
    extends BaseReferences<_$AppDatabase, $TrailersTable, TrailerRow> {
  $$TrailersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TrailerTypesTable _trailerTypeIdTable(_$AppDatabase db) =>
      db.trailerTypes.createAlias('trailer__trailer_type_id__trailer_type__id');

  $$TrailerTypesTableProcessedTableManager get trailerTypeId {
    final $_column = $_itemColumn<int>('trailer_type_id')!;

    final manager = $$TrailerTypesTableTableManager(
      $_db,
      $_db.trailerTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trailerTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RentalContractsTable, List<RentalContractRow>>
  _rentalContractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rentalContracts,
    aliasName: 'trailer__id__rental_contract__trailer_id',
  );

  $$RentalContractsTableProcessedTableManager get rentalContractsRefs {
    final manager = $$RentalContractsTableTableManager(
      $_db,
      $_db.rentalContracts,
    ).filter((f) => f.trailerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _rentalContractsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TrailerStatusChangesTable,
    List<TrailerStatusChangeRow>
  >
  _trailerStatusChangesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.trailerStatusChanges,
        aliasName: 'trailer__id__trailer_status_change__trailer_id',
      );

  $$TrailerStatusChangesTableProcessedTableManager
  get trailerStatusChangesRefs {
    final manager = $$TrailerStatusChangesTableTableManager(
      $_db,
      $_db.trailerStatusChanges,
    ).filter((f) => f.trailerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _trailerStatusChangesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DamageRecordsTable, List<DamageRecordRow>>
  _damageRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.damageRecords,
    aliasName: 'trailer__id__damage_record__trailer_id',
  );

  $$DamageRecordsTableProcessedTableManager get damageRecordsRefs {
    final manager = $$DamageRecordsTableTableManager(
      $_db,
      $_db.damageRecords,
    ).filter((f) => f.trailerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_damageRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhotosTable, List<PhotoRow>> _photosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.photos,
    aliasName: 'trailer__id__photo__trailer_id',
  );

  $$PhotosTableProcessedTableManager get photosRefs {
    final manager = $$PhotosTableTableManager(
      $_db,
      $_db.photos,
    ).filter((f) => f.trailerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_photosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TrailersTableFilterComposer
    extends Composer<_$AppDatabase, $TrailersTable> {
  $$TrailersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get internalCode => $composableBuilder(
    column: $table.internalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TrailerStatus, TrailerStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get locationAddress => $composableBuilder(
    column: $table.locationAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get locationLatitude => $composableBuilder(
    column: $table.locationLatitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get locationLongitude => $composableBuilder(
    column: $table.locationLongitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get locationUpdatedAt => $composableBuilder(
    column: $table.locationUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TrailerTypesTableFilterComposer get trailerTypeId {
    final $$TrailerTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerTypeId,
      referencedTable: $db.trailerTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailerTypesTableFilterComposer(
            $db: $db,
            $table: $db.trailerTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> rentalContractsRefs(
    Expression<bool> Function($$RentalContractsTableFilterComposer f) f,
  ) {
    final $$RentalContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.trailerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableFilterComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> trailerStatusChangesRefs(
    Expression<bool> Function($$TrailerStatusChangesTableFilterComposer f) f,
  ) {
    final $$TrailerStatusChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trailerStatusChanges,
      getReferencedColumn: (t) => t.trailerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailerStatusChangesTableFilterComposer(
            $db: $db,
            $table: $db.trailerStatusChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> damageRecordsRefs(
    Expression<bool> Function($$DamageRecordsTableFilterComposer f) f,
  ) {
    final $$DamageRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.trailerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableFilterComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> photosRefs(
    Expression<bool> Function($$PhotosTableFilterComposer f) f,
  ) {
    final $$PhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photos,
      getReferencedColumn: (t) => t.trailerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotosTableFilterComposer(
            $db: $db,
            $table: $db.photos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrailersTableOrderingComposer
    extends Composer<_$AppDatabase, $TrailersTable> {
  $$TrailersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get internalCode => $composableBuilder(
    column: $table.internalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationAddress => $composableBuilder(
    column: $table.locationAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get locationLatitude => $composableBuilder(
    column: $table.locationLatitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get locationLongitude => $composableBuilder(
    column: $table.locationLongitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get locationUpdatedAt => $composableBuilder(
    column: $table.locationUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrailerTypesTableOrderingComposer get trailerTypeId {
    final $$TrailerTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerTypeId,
      referencedTable: $db.trailerTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailerTypesTableOrderingComposer(
            $db: $db,
            $table: $db.trailerTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrailersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrailersTable> {
  $$TrailersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get internalCode => $composableBuilder(
    column: $table.internalCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get licensePlate => $composableBuilder(
    column: $table.licensePlate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TrailerStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get locationAddress => $composableBuilder(
    column: $table.locationAddress,
    builder: (column) => column,
  );

  GeneratedColumn<double> get locationLatitude => $composableBuilder(
    column: $table.locationLatitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get locationLongitude => $composableBuilder(
    column: $table.locationLongitude,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get locationUpdatedAt => $composableBuilder(
    column: $table.locationUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TrailerTypesTableAnnotationComposer get trailerTypeId {
    final $$TrailerTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerTypeId,
      referencedTable: $db.trailerTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailerTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.trailerTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> rentalContractsRefs<T extends Object>(
    Expression<T> Function($$RentalContractsTableAnnotationComposer a) f,
  ) {
    final $$RentalContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.trailerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> trailerStatusChangesRefs<T extends Object>(
    Expression<T> Function($$TrailerStatusChangesTableAnnotationComposer a) f,
  ) {
    final $$TrailerStatusChangesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.trailerStatusChanges,
          getReferencedColumn: (t) => t.trailerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TrailerStatusChangesTableAnnotationComposer(
                $db: $db,
                $table: $db.trailerStatusChanges,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> damageRecordsRefs<T extends Object>(
    Expression<T> Function($$DamageRecordsTableAnnotationComposer a) f,
  ) {
    final $$DamageRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.trailerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> photosRefs<T extends Object>(
    Expression<T> Function($$PhotosTableAnnotationComposer a) f,
  ) {
    final $$PhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photos,
      getReferencedColumn: (t) => t.trailerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.photos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrailersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrailersTable,
          TrailerRow,
          $$TrailersTableFilterComposer,
          $$TrailersTableOrderingComposer,
          $$TrailersTableAnnotationComposer,
          $$TrailersTableCreateCompanionBuilder,
          $$TrailersTableUpdateCompanionBuilder,
          (TrailerRow, $$TrailersTableReferences),
          TrailerRow,
          PrefetchHooks Function({
            bool trailerTypeId,
            bool rentalContractsRefs,
            bool trailerStatusChangesRefs,
            bool damageRecordsRefs,
            bool photosRefs,
          })
        > {
  $$TrailersTableTableManager(_$AppDatabase db, $TrailersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrailersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrailersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrailersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> internalCode = const Value.absent(),
                Value<String> licensePlate = const Value.absent(),
                Value<int> trailerTypeId = const Value.absent(),
                Value<TrailerStatus> status = const Value.absent(),
                Value<String?> locationAddress = const Value.absent(),
                Value<double?> locationLatitude = const Value.absent(),
                Value<double?> locationLongitude = const Value.absent(),
                Value<DateTime?> locationUpdatedAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TrailersCompanion(
                id: id,
                internalCode: internalCode,
                licensePlate: licensePlate,
                trailerTypeId: trailerTypeId,
                status: status,
                locationAddress: locationAddress,
                locationLatitude: locationLatitude,
                locationLongitude: locationLongitude,
                locationUpdatedAt: locationUpdatedAt,
                archivedAt: archivedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String internalCode,
                required String licensePlate,
                required int trailerTypeId,
                required TrailerStatus status,
                Value<String?> locationAddress = const Value.absent(),
                Value<double?> locationLatitude = const Value.absent(),
                Value<double?> locationLongitude = const Value.absent(),
                Value<DateTime?> locationUpdatedAt = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TrailersCompanion.insert(
                id: id,
                internalCode: internalCode,
                licensePlate: licensePlate,
                trailerTypeId: trailerTypeId,
                status: status,
                locationAddress: locationAddress,
                locationLatitude: locationLatitude,
                locationLongitude: locationLongitude,
                locationUpdatedAt: locationUpdatedAt,
                archivedAt: archivedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrailersTable, TrailerRow>(table),
                  $$TrailersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                trailerTypeId = false,
                rentalContractsRefs = false,
                trailerStatusChangesRefs = false,
                damageRecordsRefs = false,
                photosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (rentalContractsRefs) db.rentalContracts,
                    if (trailerStatusChangesRefs) db.trailerStatusChanges,
                    if (damageRecordsRefs) db.damageRecords,
                    if (photosRefs) db.photos,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (trailerTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.trailerTypeId,
                                    referencedTable: $$TrailersTableReferences
                                        ._trailerTypeIdTable(db),
                                    referencedColumn: $$TrailersTableReferences
                                        ._trailerTypeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (rentalContractsRefs)
                        await $_getPrefetchedData<
                          TrailerRow,
                          $TrailersTable,
                          RentalContractRow
                        >(
                          currentTable: table,
                          referencedTable: $$TrailersTableReferences
                              ._rentalContractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TrailersTableReferences(
                                db,
                                table,
                                p0,
                              ).rentalContractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trailerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (trailerStatusChangesRefs)
                        await $_getPrefetchedData<
                          TrailerRow,
                          $TrailersTable,
                          TrailerStatusChangeRow
                        >(
                          currentTable: table,
                          referencedTable: $$TrailersTableReferences
                              ._trailerStatusChangesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TrailersTableReferences(
                                db,
                                table,
                                p0,
                              ).trailerStatusChangesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trailerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (damageRecordsRefs)
                        await $_getPrefetchedData<
                          TrailerRow,
                          $TrailersTable,
                          DamageRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$TrailersTableReferences
                              ._damageRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TrailersTableReferences(
                                db,
                                table,
                                p0,
                              ).damageRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trailerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (photosRefs)
                        await $_getPrefetchedData<
                          TrailerRow,
                          $TrailersTable,
                          PhotoRow
                        >(
                          currentTable: table,
                          referencedTable: $$TrailersTableReferences
                              ._photosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TrailersTableReferences(
                                db,
                                table,
                                p0,
                              ).photosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trailerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TrailersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrailersTable,
      TrailerRow,
      $$TrailersTableFilterComposer,
      $$TrailersTableOrderingComposer,
      $$TrailersTableAnnotationComposer,
      $$TrailersTableCreateCompanionBuilder,
      $$TrailersTableUpdateCompanionBuilder,
      (TrailerRow, $$TrailersTableReferences),
      TrailerRow,
      PrefetchHooks Function({
        bool trailerTypeId,
        bool rentalContractsRefs,
        bool trailerStatusChangesRefs,
        bool damageRecordsRefs,
        bool photosRefs,
      })
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String street,
      required String postalCode,
      required String city,
      Value<String?> licenseNumber,
      Value<DateTime?> archivedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> email,
      Value<String> phone,
      Value<String> street,
      Value<String> postalCode,
      Value<String> city,
      Value<String?> licenseNumber,
      Value<DateTime?> archivedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, CustomerRow> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RentalContractsTable, List<RentalContractRow>>
  _rentalContractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rentalContracts,
    aliasName: 'customer__id__rental_contract__customer_id',
  );

  $$RentalContractsTableProcessedTableManager get rentalContractsRefs {
    final manager = $$RentalContractsTableTableManager(
      $_db,
      $_db.rentalContracts,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _rentalContractsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DamageRecordsTable, List<DamageRecordRow>>
  _damageRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.damageRecords,
    aliasName: 'customer__id__damage_record__customer_id',
  );

  $$DamageRecordsTableProcessedTableManager get damageRecordsRefs {
    final manager = $$DamageRecordsTableTableManager(
      $_db,
      $_db.damageRecords,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_damageRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get street => $composableBuilder(
    column: $table.street,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseNumber => $composableBuilder(
    column: $table.licenseNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> rentalContractsRefs(
    Expression<bool> Function($$RentalContractsTableFilterComposer f) f,
  ) {
    final $$RentalContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableFilterComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> damageRecordsRefs(
    Expression<bool> Function($$DamageRecordsTableFilterComposer f) f,
  ) {
    final $$DamageRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableFilterComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get street => $composableBuilder(
    column: $table.street,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseNumber => $composableBuilder(
    column: $table.licenseNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get street =>
      $composableBuilder(column: $table.street, builder: (column) => column);

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get licenseNumber => $composableBuilder(
    column: $table.licenseNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> rentalContractsRefs<T extends Object>(
    Expression<T> Function($$RentalContractsTableAnnotationComposer a) f,
  ) {
    final $$RentalContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> damageRecordsRefs<T extends Object>(
    Expression<T> Function($$DamageRecordsTableAnnotationComposer a) f,
  ) {
    final $$DamageRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          CustomerRow,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (CustomerRow, $$CustomersTableReferences),
          CustomerRow,
          PrefetchHooks Function({
            bool rentalContractsRefs,
            bool damageRecordsRefs,
          })
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> street = const Value.absent(),
                Value<String> postalCode = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String?> licenseNumber = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                street: street,
                postalCode: postalCode,
                city: city,
                licenseNumber: licenseNumber,
                archivedAt: archivedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String firstName,
                required String lastName,
                required String email,
                required String phone,
                required String street,
                required String postalCode,
                required String city,
                Value<String?> licenseNumber = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                street: street,
                postalCode: postalCode,
                city: city,
                licenseNumber: licenseNumber,
                archivedAt: archivedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomersTable, CustomerRow>(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({rentalContractsRefs = false, damageRecordsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (rentalContractsRefs) db.rentalContracts,
                    if (damageRecordsRefs) db.damageRecords,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (rentalContractsRefs)
                        await $_getPrefetchedData<
                          CustomerRow,
                          $CustomersTable,
                          RentalContractRow
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._rentalContractsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).rentalContractsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (damageRecordsRefs)
                        await $_getPrefetchedData<
                          CustomerRow,
                          $CustomersTable,
                          DamageRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._damageRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).damageRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      CustomerRow,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (CustomerRow, $$CustomersTableReferences),
      CustomerRow,
      PrefetchHooks Function({bool rentalContractsRefs, bool damageRecordsRefs})
    >;
typedef $$RentalContractsTableCreateCompanionBuilder =
    RentalContractsCompanion Function({
      Value<int> id,
      required int customerId,
      required int trailerId,
      required DateTime startAt,
      required DateTime endAt,
      required String pickupLocation,
      required String returnLocation,
      required int priceCents,
      required ContractStatus status,
      Value<DateTime?> handedOverAt,
      Value<DateTime?> returnedAt,
      required int createdByUserId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$RentalContractsTableUpdateCompanionBuilder =
    RentalContractsCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<int> trailerId,
      Value<DateTime> startAt,
      Value<DateTime> endAt,
      Value<String> pickupLocation,
      Value<String> returnLocation,
      Value<int> priceCents,
      Value<ContractStatus> status,
      Value<DateTime?> handedOverAt,
      Value<DateTime?> returnedAt,
      Value<int> createdByUserId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$RentalContractsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RentalContractsTable,
          RentalContractRow
        > {
  $$RentalContractsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias('rental_contract__customer_id__customer__id');

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TrailersTable _trailerIdTable(_$AppDatabase db) =>
      db.trailers.createAlias('rental_contract__trailer_id__trailer__id');

  $$TrailersTableProcessedTableManager get trailerId {
    final $_column = $_itemColumn<int>('trailer_id')!;

    final manager = $$TrailersTableTableManager(
      $_db,
      $_db.trailers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trailerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AppUsersTable _createdByUserIdTable(_$AppDatabase db) => db.appUsers
      .createAlias('rental_contract__created_by_user_id__app_user__id');

  $$AppUsersTableProcessedTableManager get createdByUserId {
    final $_column = $_itemColumn<int>('created_by_user_id')!;

    final manager = $$AppUsersTableTableManager(
      $_db,
      $_db.appUsers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $TrailerStatusChangesTable,
    List<TrailerStatusChangeRow>
  >
  _trailerStatusChangesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.trailerStatusChanges,
        aliasName:
            'rental_contract__id__trailer_status_change__rental_contract_id',
      );

  $$TrailerStatusChangesTableProcessedTableManager
  get trailerStatusChangesRefs {
    final manager = $$TrailerStatusChangesTableTableManager(
      $_db,
      $_db.trailerStatusChanges,
    ).filter((f) => f.rentalContractId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _trailerStatusChangesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DamageRecordsTable, List<DamageRecordRow>>
  _damageRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.damageRecords,
    aliasName: 'rental_contract__id__damage_record__rental_contract_id',
  );

  $$DamageRecordsTableProcessedTableManager get damageRecordsRefs {
    final manager = $$DamageRecordsTableTableManager(
      $_db,
      $_db.damageRecords,
    ).filter((f) => f.rentalContractId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_damageRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RentalContractsTableFilterComposer
    extends Composer<_$AppDatabase, $RentalContractsTable> {
  $$RentalContractsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pickupLocation => $composableBuilder(
    column: $table.pickupLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get returnLocation => $composableBuilder(
    column: $table.returnLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceCents => $composableBuilder(
    column: $table.priceCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ContractStatus, ContractStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get handedOverAt => $composableBuilder(
    column: $table.handedOverAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TrailersTableFilterComposer get trailerId {
    final $$TrailersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableFilterComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableFilterComposer get createdByUserId {
    final $$AppUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableFilterComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> trailerStatusChangesRefs(
    Expression<bool> Function($$TrailerStatusChangesTableFilterComposer f) f,
  ) {
    final $$TrailerStatusChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trailerStatusChanges,
      getReferencedColumn: (t) => t.rentalContractId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailerStatusChangesTableFilterComposer(
            $db: $db,
            $table: $db.trailerStatusChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> damageRecordsRefs(
    Expression<bool> Function($$DamageRecordsTableFilterComposer f) f,
  ) {
    final $$DamageRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.rentalContractId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableFilterComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RentalContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $RentalContractsTable> {
  $$RentalContractsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pickupLocation => $composableBuilder(
    column: $table.pickupLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get returnLocation => $composableBuilder(
    column: $table.returnLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceCents => $composableBuilder(
    column: $table.priceCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get handedOverAt => $composableBuilder(
    column: $table.handedOverAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TrailersTableOrderingComposer get trailerId {
    final $$TrailersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableOrderingComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableOrderingComposer get createdByUserId {
    final $$AppUsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableOrderingComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RentalContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RentalContractsTable> {
  $$RentalContractsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<String> get pickupLocation => $composableBuilder(
    column: $table.pickupLocation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get returnLocation => $composableBuilder(
    column: $table.returnLocation,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priceCents => $composableBuilder(
    column: $table.priceCents,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ContractStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get handedOverAt => $composableBuilder(
    column: $table.handedOverAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get returnedAt => $composableBuilder(
    column: $table.returnedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TrailersTableAnnotationComposer get trailerId {
    final $$TrailersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableAnnotationComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableAnnotationComposer get createdByUserId {
    final $$AppUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> trailerStatusChangesRefs<T extends Object>(
    Expression<T> Function($$TrailerStatusChangesTableAnnotationComposer a) f,
  ) {
    final $$TrailerStatusChangesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.trailerStatusChanges,
          getReferencedColumn: (t) => t.rentalContractId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TrailerStatusChangesTableAnnotationComposer(
                $db: $db,
                $table: $db.trailerStatusChanges,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> damageRecordsRefs<T extends Object>(
    Expression<T> Function($$DamageRecordsTableAnnotationComposer a) f,
  ) {
    final $$DamageRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.rentalContractId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RentalContractsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RentalContractsTable,
          RentalContractRow,
          $$RentalContractsTableFilterComposer,
          $$RentalContractsTableOrderingComposer,
          $$RentalContractsTableAnnotationComposer,
          $$RentalContractsTableCreateCompanionBuilder,
          $$RentalContractsTableUpdateCompanionBuilder,
          (RentalContractRow, $$RentalContractsTableReferences),
          RentalContractRow,
          PrefetchHooks Function({
            bool customerId,
            bool trailerId,
            bool createdByUserId,
            bool trailerStatusChangesRefs,
            bool damageRecordsRefs,
          })
        > {
  $$RentalContractsTableTableManager(
    _$AppDatabase db,
    $RentalContractsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RentalContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RentalContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RentalContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<int> trailerId = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<DateTime> endAt = const Value.absent(),
                Value<String> pickupLocation = const Value.absent(),
                Value<String> returnLocation = const Value.absent(),
                Value<int> priceCents = const Value.absent(),
                Value<ContractStatus> status = const Value.absent(),
                Value<DateTime?> handedOverAt = const Value.absent(),
                Value<DateTime?> returnedAt = const Value.absent(),
                Value<int> createdByUserId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RentalContractsCompanion(
                id: id,
                customerId: customerId,
                trailerId: trailerId,
                startAt: startAt,
                endAt: endAt,
                pickupLocation: pickupLocation,
                returnLocation: returnLocation,
                priceCents: priceCents,
                status: status,
                handedOverAt: handedOverAt,
                returnedAt: returnedAt,
                createdByUserId: createdByUserId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                required int trailerId,
                required DateTime startAt,
                required DateTime endAt,
                required String pickupLocation,
                required String returnLocation,
                required int priceCents,
                required ContractStatus status,
                Value<DateTime?> handedOverAt = const Value.absent(),
                Value<DateTime?> returnedAt = const Value.absent(),
                required int createdByUserId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RentalContractsCompanion.insert(
                id: id,
                customerId: customerId,
                trailerId: trailerId,
                startAt: startAt,
                endAt: endAt,
                pickupLocation: pickupLocation,
                returnLocation: returnLocation,
                priceCents: priceCents,
                status: status,
                handedOverAt: handedOverAt,
                returnedAt: returnedAt,
                createdByUserId: createdByUserId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RentalContractsTable, RentalContractRow>(table),
                  $$RentalContractsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                customerId = false,
                trailerId = false,
                createdByUserId = false,
                trailerStatusChangesRefs = false,
                damageRecordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (trailerStatusChangesRefs) db.trailerStatusChanges,
                    if (damageRecordsRefs) db.damageRecords,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable:
                                        $$RentalContractsTableReferences
                                            ._customerIdTable(db),
                                    referencedColumn:
                                        $$RentalContractsTableReferences
                                            ._customerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (trailerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.trailerId,
                                    referencedTable:
                                        $$RentalContractsTableReferences
                                            ._trailerIdTable(db),
                                    referencedColumn:
                                        $$RentalContractsTableReferences
                                            ._trailerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (createdByUserId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.createdByUserId,
                                    referencedTable:
                                        $$RentalContractsTableReferences
                                            ._createdByUserIdTable(db),
                                    referencedColumn:
                                        $$RentalContractsTableReferences
                                            ._createdByUserIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (trailerStatusChangesRefs)
                        await $_getPrefetchedData<
                          RentalContractRow,
                          $RentalContractsTable,
                          TrailerStatusChangeRow
                        >(
                          currentTable: table,
                          referencedTable: $$RentalContractsTableReferences
                              ._trailerStatusChangesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RentalContractsTableReferences(
                                db,
                                table,
                                p0,
                              ).trailerStatusChangesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.rentalContractId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (damageRecordsRefs)
                        await $_getPrefetchedData<
                          RentalContractRow,
                          $RentalContractsTable,
                          DamageRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$RentalContractsTableReferences
                              ._damageRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RentalContractsTableReferences(
                                db,
                                table,
                                p0,
                              ).damageRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.rentalContractId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RentalContractsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RentalContractsTable,
      RentalContractRow,
      $$RentalContractsTableFilterComposer,
      $$RentalContractsTableOrderingComposer,
      $$RentalContractsTableAnnotationComposer,
      $$RentalContractsTableCreateCompanionBuilder,
      $$RentalContractsTableUpdateCompanionBuilder,
      (RentalContractRow, $$RentalContractsTableReferences),
      RentalContractRow,
      PrefetchHooks Function({
        bool customerId,
        bool trailerId,
        bool createdByUserId,
        bool trailerStatusChangesRefs,
        bool damageRecordsRefs,
      })
    >;
typedef $$TrailerStatusChangesTableCreateCompanionBuilder =
    TrailerStatusChangesCompanion Function({
      Value<int> id,
      required int trailerId,
      Value<TrailerStatus?> oldStatus,
      required TrailerStatus newStatus,
      Value<DateTime> changedAt,
      required int changedByUserId,
      Value<int?> rentalContractId,
    });
typedef $$TrailerStatusChangesTableUpdateCompanionBuilder =
    TrailerStatusChangesCompanion Function({
      Value<int> id,
      Value<int> trailerId,
      Value<TrailerStatus?> oldStatus,
      Value<TrailerStatus> newStatus,
      Value<DateTime> changedAt,
      Value<int> changedByUserId,
      Value<int?> rentalContractId,
    });

final class $$TrailerStatusChangesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TrailerStatusChangesTable,
          TrailerStatusChangeRow
        > {
  $$TrailerStatusChangesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TrailersTable _trailerIdTable(_$AppDatabase db) =>
      db.trailers.createAlias('trailer_status_change__trailer_id__trailer__id');

  $$TrailersTableProcessedTableManager get trailerId {
    final $_column = $_itemColumn<int>('trailer_id')!;

    final manager = $$TrailersTableTableManager(
      $_db,
      $_db.trailers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trailerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AppUsersTable _changedByUserIdTable(_$AppDatabase db) => db.appUsers
      .createAlias('trailer_status_change__changed_by_user_id__app_user__id');

  $$AppUsersTableProcessedTableManager get changedByUserId {
    final $_column = $_itemColumn<int>('changed_by_user_id')!;

    final manager = $$AppUsersTableTableManager(
      $_db,
      $_db.appUsers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_changedByUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RentalContractsTable _rentalContractIdTable(_$AppDatabase db) =>
      db.rentalContracts.createAlias(
        'trailer_status_change__rental_contract_id__rental_contract__id',
      );

  $$RentalContractsTableProcessedTableManager? get rentalContractId {
    final $_column = $_itemColumn<int>('rental_contract_id');
    if ($_column == null) return null;
    final manager = $$RentalContractsTableTableManager(
      $_db,
      $_db.rentalContracts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rentalContractIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrailerStatusChangesTableFilterComposer
    extends Composer<_$AppDatabase, $TrailerStatusChangesTable> {
  $$TrailerStatusChangesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TrailerStatus?, TrailerStatus, String>
  get oldStatus => $composableBuilder(
    column: $table.oldStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TrailerStatus, TrailerStatus, String>
  get newStatus => $composableBuilder(
    column: $table.newStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TrailersTableFilterComposer get trailerId {
    final $$TrailersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableFilterComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableFilterComposer get changedByUserId {
    final $$AppUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.changedByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableFilterComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RentalContractsTableFilterComposer get rentalContractId {
    final $$RentalContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rentalContractId,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableFilterComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrailerStatusChangesTableOrderingComposer
    extends Composer<_$AppDatabase, $TrailerStatusChangesTable> {
  $$TrailerStatusChangesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get oldStatus => $composableBuilder(
    column: $table.oldStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newStatus => $composableBuilder(
    column: $table.newStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrailersTableOrderingComposer get trailerId {
    final $$TrailersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableOrderingComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableOrderingComposer get changedByUserId {
    final $$AppUsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.changedByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableOrderingComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RentalContractsTableOrderingComposer get rentalContractId {
    final $$RentalContractsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rentalContractId,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableOrderingComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrailerStatusChangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrailerStatusChangesTable> {
  $$TrailerStatusChangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TrailerStatus?, String> get oldStatus =>
      $composableBuilder(column: $table.oldStatus, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TrailerStatus, String> get newStatus =>
      $composableBuilder(column: $table.newStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  $$TrailersTableAnnotationComposer get trailerId {
    final $$TrailersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableAnnotationComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableAnnotationComposer get changedByUserId {
    final $$AppUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.changedByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RentalContractsTableAnnotationComposer get rentalContractId {
    final $$RentalContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rentalContractId,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrailerStatusChangesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrailerStatusChangesTable,
          TrailerStatusChangeRow,
          $$TrailerStatusChangesTableFilterComposer,
          $$TrailerStatusChangesTableOrderingComposer,
          $$TrailerStatusChangesTableAnnotationComposer,
          $$TrailerStatusChangesTableCreateCompanionBuilder,
          $$TrailerStatusChangesTableUpdateCompanionBuilder,
          (TrailerStatusChangeRow, $$TrailerStatusChangesTableReferences),
          TrailerStatusChangeRow,
          PrefetchHooks Function({
            bool trailerId,
            bool changedByUserId,
            bool rentalContractId,
          })
        > {
  $$TrailerStatusChangesTableTableManager(
    _$AppDatabase db,
    $TrailerStatusChangesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrailerStatusChangesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrailerStatusChangesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TrailerStatusChangesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> trailerId = const Value.absent(),
                Value<TrailerStatus?> oldStatus = const Value.absent(),
                Value<TrailerStatus> newStatus = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
                Value<int> changedByUserId = const Value.absent(),
                Value<int?> rentalContractId = const Value.absent(),
              }) => TrailerStatusChangesCompanion(
                id: id,
                trailerId: trailerId,
                oldStatus: oldStatus,
                newStatus: newStatus,
                changedAt: changedAt,
                changedByUserId: changedByUserId,
                rentalContractId: rentalContractId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int trailerId,
                Value<TrailerStatus?> oldStatus = const Value.absent(),
                required TrailerStatus newStatus,
                Value<DateTime> changedAt = const Value.absent(),
                required int changedByUserId,
                Value<int?> rentalContractId = const Value.absent(),
              }) => TrailerStatusChangesCompanion.insert(
                id: id,
                trailerId: trailerId,
                oldStatus: oldStatus,
                newStatus: newStatus,
                changedAt: changedAt,
                changedByUserId: changedByUserId,
                rentalContractId: rentalContractId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $TrailerStatusChangesTable,
                    TrailerStatusChangeRow
                  >(table),
                  $$TrailerStatusChangesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                trailerId = false,
                changedByUserId = false,
                rentalContractId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (trailerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.trailerId,
                                    referencedTable:
                                        $$TrailerStatusChangesTableReferences
                                            ._trailerIdTable(db),
                                    referencedColumn:
                                        $$TrailerStatusChangesTableReferences
                                            ._trailerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (changedByUserId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.changedByUserId,
                                    referencedTable:
                                        $$TrailerStatusChangesTableReferences
                                            ._changedByUserIdTable(db),
                                    referencedColumn:
                                        $$TrailerStatusChangesTableReferences
                                            ._changedByUserIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (rentalContractId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.rentalContractId,
                                    referencedTable:
                                        $$TrailerStatusChangesTableReferences
                                            ._rentalContractIdTable(db),
                                    referencedColumn:
                                        $$TrailerStatusChangesTableReferences
                                            ._rentalContractIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TrailerStatusChangesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrailerStatusChangesTable,
      TrailerStatusChangeRow,
      $$TrailerStatusChangesTableFilterComposer,
      $$TrailerStatusChangesTableOrderingComposer,
      $$TrailerStatusChangesTableAnnotationComposer,
      $$TrailerStatusChangesTableCreateCompanionBuilder,
      $$TrailerStatusChangesTableUpdateCompanionBuilder,
      (TrailerStatusChangeRow, $$TrailerStatusChangesTableReferences),
      TrailerStatusChangeRow,
      PrefetchHooks Function({
        bool trailerId,
        bool changedByUserId,
        bool rentalContractId,
      })
    >;
typedef $$DamageRecordsTableCreateCompanionBuilder =
    DamageRecordsCompanion Function({
      Value<int> id,
      required int trailerId,
      required DateTime eventDate,
      required String description,
      required DamageType damageType,
      required DamageCause causedBy,
      Value<int?> customerId,
      Value<int?> rentalContractId,
      Value<int?> costCents,
      required int createdByUserId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$DamageRecordsTableUpdateCompanionBuilder =
    DamageRecordsCompanion Function({
      Value<int> id,
      Value<int> trailerId,
      Value<DateTime> eventDate,
      Value<String> description,
      Value<DamageType> damageType,
      Value<DamageCause> causedBy,
      Value<int?> customerId,
      Value<int?> rentalContractId,
      Value<int?> costCents,
      Value<int> createdByUserId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$DamageRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $DamageRecordsTable, DamageRecordRow> {
  $$DamageRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TrailersTable _trailerIdTable(_$AppDatabase db) =>
      db.trailers.createAlias('damage_record__trailer_id__trailer__id');

  $$TrailersTableProcessedTableManager get trailerId {
    final $_column = $_itemColumn<int>('trailer_id')!;

    final manager = $$TrailersTableTableManager(
      $_db,
      $_db.trailers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trailerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias('damage_record__customer_id__customer__id');

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RentalContractsTable _rentalContractIdTable(_$AppDatabase db) => db
      .rentalContracts
      .createAlias('damage_record__rental_contract_id__rental_contract__id');

  $$RentalContractsTableProcessedTableManager? get rentalContractId {
    final $_column = $_itemColumn<int>('rental_contract_id');
    if ($_column == null) return null;
    final manager = $$RentalContractsTableTableManager(
      $_db,
      $_db.rentalContracts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rentalContractIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AppUsersTable _createdByUserIdTable(_$AppDatabase db) => db.appUsers
      .createAlias('damage_record__created_by_user_id__app_user__id');

  $$AppUsersTableProcessedTableManager get createdByUserId {
    final $_column = $_itemColumn<int>('created_by_user_id')!;

    final manager = $$AppUsersTableTableManager(
      $_db,
      $_db.appUsers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PhotosTable, List<PhotoRow>> _photosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.photos,
    aliasName: 'damage_record__id__photo__damage_record_id',
  );

  $$PhotosTableProcessedTableManager get photosRefs {
    final manager = $$PhotosTableTableManager(
      $_db,
      $_db.photos,
    ).filter((f) => f.damageRecordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_photosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DamageRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $DamageRecordsTable> {
  $$DamageRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DamageType, DamageType, String>
  get damageType => $composableBuilder(
    column: $table.damageType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<DamageCause, DamageCause, String>
  get causedBy => $composableBuilder(
    column: $table.causedBy,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get costCents => $composableBuilder(
    column: $table.costCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TrailersTableFilterComposer get trailerId {
    final $$TrailersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableFilterComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RentalContractsTableFilterComposer get rentalContractId {
    final $$RentalContractsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rentalContractId,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableFilterComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableFilterComposer get createdByUserId {
    final $$AppUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableFilterComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> photosRefs(
    Expression<bool> Function($$PhotosTableFilterComposer f) f,
  ) {
    final $$PhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photos,
      getReferencedColumn: (t) => t.damageRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotosTableFilterComposer(
            $db: $db,
            $table: $db.photos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DamageRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DamageRecordsTable> {
  $$DamageRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageType => $composableBuilder(
    column: $table.damageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get causedBy => $composableBuilder(
    column: $table.causedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costCents => $composableBuilder(
    column: $table.costCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrailersTableOrderingComposer get trailerId {
    final $$TrailersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableOrderingComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RentalContractsTableOrderingComposer get rentalContractId {
    final $$RentalContractsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rentalContractId,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableOrderingComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableOrderingComposer get createdByUserId {
    final $$AppUsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableOrderingComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DamageRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DamageRecordsTable> {
  $$DamageRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get eventDate =>
      $composableBuilder(column: $table.eventDate, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DamageType, String> get damageType =>
      $composableBuilder(
        column: $table.damageType,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<DamageCause, String> get causedBy =>
      $composableBuilder(column: $table.causedBy, builder: (column) => column);

  GeneratedColumn<int> get costCents =>
      $composableBuilder(column: $table.costCents, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TrailersTableAnnotationComposer get trailerId {
    final $$TrailersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableAnnotationComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RentalContractsTableAnnotationComposer get rentalContractId {
    final $$RentalContractsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rentalContractId,
      referencedTable: $db.rentalContracts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RentalContractsTableAnnotationComposer(
            $db: $db,
            $table: $db.rentalContracts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AppUsersTableAnnotationComposer get createdByUserId {
    final $$AppUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByUserId,
      referencedTable: $db.appUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.appUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> photosRefs<T extends Object>(
    Expression<T> Function($$PhotosTableAnnotationComposer a) f,
  ) {
    final $$PhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photos,
      getReferencedColumn: (t) => t.damageRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.photos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DamageRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DamageRecordsTable,
          DamageRecordRow,
          $$DamageRecordsTableFilterComposer,
          $$DamageRecordsTableOrderingComposer,
          $$DamageRecordsTableAnnotationComposer,
          $$DamageRecordsTableCreateCompanionBuilder,
          $$DamageRecordsTableUpdateCompanionBuilder,
          (DamageRecordRow, $$DamageRecordsTableReferences),
          DamageRecordRow,
          PrefetchHooks Function({
            bool trailerId,
            bool customerId,
            bool rentalContractId,
            bool createdByUserId,
            bool photosRefs,
          })
        > {
  $$DamageRecordsTableTableManager(_$AppDatabase db, $DamageRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DamageRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DamageRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DamageRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> trailerId = const Value.absent(),
                Value<DateTime> eventDate = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DamageType> damageType = const Value.absent(),
                Value<DamageCause> causedBy = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<int?> rentalContractId = const Value.absent(),
                Value<int?> costCents = const Value.absent(),
                Value<int> createdByUserId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DamageRecordsCompanion(
                id: id,
                trailerId: trailerId,
                eventDate: eventDate,
                description: description,
                damageType: damageType,
                causedBy: causedBy,
                customerId: customerId,
                rentalContractId: rentalContractId,
                costCents: costCents,
                createdByUserId: createdByUserId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int trailerId,
                required DateTime eventDate,
                required String description,
                required DamageType damageType,
                required DamageCause causedBy,
                Value<int?> customerId = const Value.absent(),
                Value<int?> rentalContractId = const Value.absent(),
                Value<int?> costCents = const Value.absent(),
                required int createdByUserId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DamageRecordsCompanion.insert(
                id: id,
                trailerId: trailerId,
                eventDate: eventDate,
                description: description,
                damageType: damageType,
                causedBy: causedBy,
                customerId: customerId,
                rentalContractId: rentalContractId,
                costCents: costCents,
                createdByUserId: createdByUserId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DamageRecordsTable, DamageRecordRow>(table),
                  $$DamageRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                trailerId = false,
                customerId = false,
                rentalContractId = false,
                createdByUserId = false,
                photosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (photosRefs) db.photos],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (trailerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.trailerId,
                                    referencedTable:
                                        $$DamageRecordsTableReferences
                                            ._trailerIdTable(db),
                                    referencedColumn:
                                        $$DamageRecordsTableReferences
                                            ._trailerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable:
                                        $$DamageRecordsTableReferences
                                            ._customerIdTable(db),
                                    referencedColumn:
                                        $$DamageRecordsTableReferences
                                            ._customerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (rentalContractId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.rentalContractId,
                                    referencedTable:
                                        $$DamageRecordsTableReferences
                                            ._rentalContractIdTable(db),
                                    referencedColumn:
                                        $$DamageRecordsTableReferences
                                            ._rentalContractIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (createdByUserId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.createdByUserId,
                                    referencedTable:
                                        $$DamageRecordsTableReferences
                                            ._createdByUserIdTable(db),
                                    referencedColumn:
                                        $$DamageRecordsTableReferences
                                            ._createdByUserIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (photosRefs)
                        await $_getPrefetchedData<
                          DamageRecordRow,
                          $DamageRecordsTable,
                          PhotoRow
                        >(
                          currentTable: table,
                          referencedTable: $$DamageRecordsTableReferences
                              ._photosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DamageRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).photosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.damageRecordId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DamageRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DamageRecordsTable,
      DamageRecordRow,
      $$DamageRecordsTableFilterComposer,
      $$DamageRecordsTableOrderingComposer,
      $$DamageRecordsTableAnnotationComposer,
      $$DamageRecordsTableCreateCompanionBuilder,
      $$DamageRecordsTableUpdateCompanionBuilder,
      (DamageRecordRow, $$DamageRecordsTableReferences),
      DamageRecordRow,
      PrefetchHooks Function({
        bool trailerId,
        bool customerId,
        bool rentalContractId,
        bool createdByUserId,
        bool photosRefs,
      })
    >;
typedef $$PhotosTableCreateCompanionBuilder =
    PhotosCompanion Function({
      Value<int> id,
      Value<int?> trailerId,
      Value<int?> damageRecordId,
      required String filePath,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });
typedef $$PhotosTableUpdateCompanionBuilder =
    PhotosCompanion Function({
      Value<int> id,
      Value<int?> trailerId,
      Value<int?> damageRecordId,
      Value<String> filePath,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
    });

final class $$PhotosTableReferences
    extends BaseReferences<_$AppDatabase, $PhotosTable, PhotoRow> {
  $$PhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TrailersTable _trailerIdTable(_$AppDatabase db) =>
      db.trailers.createAlias('photo__trailer_id__trailer__id');

  $$TrailersTableProcessedTableManager? get trailerId {
    final $_column = $_itemColumn<int>('trailer_id');
    if ($_column == null) return null;
    final manager = $$TrailersTableTableManager(
      $_db,
      $_db.trailers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trailerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DamageRecordsTable _damageRecordIdTable(_$AppDatabase db) => db
      .damageRecords
      .createAlias('photo__damage_record_id__damage_record__id');

  $$DamageRecordsTableProcessedTableManager? get damageRecordId {
    final $_column = $_itemColumn<int>('damage_record_id');
    if ($_column == null) return null;
    final manager = $$DamageRecordsTableTableManager(
      $_db,
      $_db.damageRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_damageRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhotosTableFilterComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TrailersTableFilterComposer get trailerId {
    final $$TrailersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableFilterComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DamageRecordsTableFilterComposer get damageRecordId {
    final $$DamageRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.damageRecordId,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableFilterComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrailersTableOrderingComposer get trailerId {
    final $$TrailersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableOrderingComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DamageRecordsTableOrderingComposer get damageRecordId {
    final $$DamageRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.damageRecordId,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TrailersTableAnnotationComposer get trailerId {
    final $$TrailersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trailerId,
      referencedTable: $db.trailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrailersTableAnnotationComposer(
            $db: $db,
            $table: $db.trailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DamageRecordsTableAnnotationComposer get damageRecordId {
    final $$DamageRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.damageRecordId,
      referencedTable: $db.damageRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DamageRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.damageRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotosTable,
          PhotoRow,
          $$PhotosTableFilterComposer,
          $$PhotosTableOrderingComposer,
          $$PhotosTableAnnotationComposer,
          $$PhotosTableCreateCompanionBuilder,
          $$PhotosTableUpdateCompanionBuilder,
          (PhotoRow, $$PhotosTableReferences),
          PhotoRow,
          PrefetchHooks Function({bool trailerId, bool damageRecordId})
        > {
  $$PhotosTableTableManager(_$AppDatabase db, $PhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> trailerId = const Value.absent(),
                Value<int?> damageRecordId = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PhotosCompanion(
                id: id,
                trailerId: trailerId,
                damageRecordId: damageRecordId,
                filePath: filePath,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> trailerId = const Value.absent(),
                Value<int?> damageRecordId = const Value.absent(),
                required String filePath,
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PhotosCompanion.insert(
                id: id,
                trailerId: trailerId,
                damageRecordId: damageRecordId,
                filePath: filePath,
                sortOrder: sortOrder,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PhotosTable, PhotoRow>(table),
                  $$PhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trailerId = false, damageRecordId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (trailerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trailerId,
                                referencedTable: $$PhotosTableReferences
                                    ._trailerIdTable(db),
                                referencedColumn: $$PhotosTableReferences
                                    ._trailerIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (damageRecordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.damageRecordId,
                                referencedTable: $$PhotosTableReferences
                                    ._damageRecordIdTable(db),
                                referencedColumn: $$PhotosTableReferences
                                    ._damageRecordIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotosTable,
      PhotoRow,
      $$PhotosTableFilterComposer,
      $$PhotosTableOrderingComposer,
      $$PhotosTableAnnotationComposer,
      $$PhotosTableCreateCompanionBuilder,
      $$PhotosTableUpdateCompanionBuilder,
      (PhotoRow, $$PhotosTableReferences),
      PhotoRow,
      PrefetchHooks Function({bool trailerId, bool damageRecordId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppUsersTableTableManager get appUsers =>
      $$AppUsersTableTableManager(_db, _db.appUsers);
  $$TrailerTypesTableTableManager get trailerTypes =>
      $$TrailerTypesTableTableManager(_db, _db.trailerTypes);
  $$TrailersTableTableManager get trailers =>
      $$TrailersTableTableManager(_db, _db.trailers);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$RentalContractsTableTableManager get rentalContracts =>
      $$RentalContractsTableTableManager(_db, _db.rentalContracts);
  $$TrailerStatusChangesTableTableManager get trailerStatusChanges =>
      $$TrailerStatusChangesTableTableManager(_db, _db.trailerStatusChanges);
  $$DamageRecordsTableTableManager get damageRecords =>
      $$DamageRecordsTableTableManager(_db, _db.damageRecords);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db, _db.photos);
}

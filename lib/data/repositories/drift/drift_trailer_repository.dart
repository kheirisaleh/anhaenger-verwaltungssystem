import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../models/enums.dart';
import '../../models/trailer.dart';
import '../repository_exception.dart';
import '../trailer_repository.dart';

class DriftTrailerRepository implements TrailerRepository {
  DriftTrailerRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Trailer>> watchAll({TrailerQuery query = const TrailerQuery()}) {
    final JoinedSelectStatement<HasResultSet, dynamic> select = _joinedSelect();
    if (!query.includeArchived) {
      select.where(_db.trailers.archivedAt.isNull());
    }
    final TrailerStatus? status = query.status;
    if (status != null) {
      select.where(_db.trailers.status.equalsValue(status));
    }
    final String search = query.search?.trim() ?? '';
    if (search.isNotEmpty) {
      final String pattern = '%$search%';
      select.where(
        _db.trailers.internalCode.like(pattern) |
            _db.trailers.licensePlate.like(pattern) |
            _db.trailerTypes.name.like(pattern),
      );
    }
    select.orderBy(<OrderingTerm>[OrderingTerm.asc(_db.trailers.internalCode)]);
    return select.watch().map(
      (List<TypedResult> rows) => rows.map(_mapResult).toList(),
    );
  }

  @override
  Stream<Trailer?> watchById(int id) {
    final JoinedSelectStatement<HasResultSet, dynamic> select = _joinedSelect()
      ..where(_db.trailers.id.equals(id));
    return select.watchSingleOrNull().map(
      (TypedResult? row) => row == null ? null : _mapResult(row),
    );
  }

  @override
  Future<Trailer> create(TrailerDraft draft, {required int userId}) {
    return _db.transaction(() async {
      final String internalCode = draft.internalCode.trim();
      final String licensePlate = _normalizePlate(draft.licensePlate);
      await _ensureUnique(internalCode, licensePlate);
      final int id = await _db
          .into(_db.trailers)
          .insert(
            TrailersCompanion.insert(
              internalCode: internalCode,
              licensePlate: licensePlate,
              trailerTypeId: draft.typeId,
              status: TrailerStatus.available,
            ),
          );
      await _logStatusChange(
        trailerId: id,
        oldStatus: null,
        newStatus: TrailerStatus.available,
        userId: userId,
      );
      return _requireTrailer(id);
    });
  }

  @override
  Future<void> update(int id, TrailerDraft draft) {
    return _db.transaction(() async {
      await _requireRow(id);
      final String internalCode = draft.internalCode.trim();
      final String licensePlate = _normalizePlate(draft.licensePlate);
      await _ensureUnique(internalCode, licensePlate, excludeId: id);
      await _write(
        id,
        TrailersCompanion(
          internalCode: Value<String>(internalCode),
          licensePlate: Value<String>(licensePlate),
          trailerTypeId: Value<int>(draft.typeId),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    });
  }

  @override
  Future<void> changeStatus(
    int id,
    TrailerStatus status, {
    required int userId,
  }) {
    return _db.transaction(() async {
      final TrailerRow row = await _requireRow(id);
      if (status == TrailerStatus.rented) {
        throw const RepositoryException(RepositoryError.rentedStatusManual);
      }
      if (row.status == TrailerStatus.rented) {
        throw const RepositoryException(RepositoryError.statusChangeNotAllowed);
      }
      if (row.status == status) {
        return;
      }
      await _write(
        id,
        TrailersCompanion(
          status: Value<TrailerStatus>(status),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
      await _logStatusChange(
        trailerId: id,
        oldStatus: row.status,
        newStatus: status,
        userId: userId,
      );
    });
  }

  @override
  Future<void> updateLocation(int id, TrailerLocation location) {
    return _db.transaction(() async {
      await _requireRow(id);
      final String? address = location.address?.trim();
      final DateTime now = DateTime.now();
      await _write(
        id,
        TrailersCompanion(
          locationAddress: Value<String?>(
            address == null || address.isEmpty ? null : address,
          ),
          locationLatitude: Value<double?>(location.latitude),
          locationLongitude: Value<double?>(location.longitude),
          locationUpdatedAt: Value<DateTime?>(now),
          updatedAt: Value<DateTime>(now),
        ),
      );
    });
  }

  @override
  Future<void> archive(int id) {
    return _db.transaction(() async {
      final TrailerRow row = await _requireRow(id);
      if (row.archivedAt != null) {
        return;
      }
      final List<RentalContractRow> contracts = await (_db.select(
        _db.rentalContracts,
      )..where(($RentalContractsTable t) => t.trailerId.equals(id))).get();
      if (contracts.any((RentalContractRow c) => c.status.blocksTrailer)) {
        throw const RepositoryException(
          RepositoryError.trailerHasOpenContracts,
        );
      }
      final DateTime now = DateTime.now();
      await _write(
        id,
        TrailersCompanion(
          archivedAt: Value<DateTime?>(now),
          updatedAt: Value<DateTime>(now),
        ),
      );
    });
  }

  @override
  Future<void> restore(int id) {
    return _db.transaction(() async {
      await _requireRow(id);
      await _write(
        id,
        TrailersCompanion(
          archivedAt: const Value<DateTime?>(null),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    });
  }

  @override
  Stream<List<TrailerStatusChange>> watchStatusHistory(int trailerId) {
    final JoinedSelectStatement<HasResultSet, dynamic> select =
        _db.select(_db.trailerStatusChanges).join(<Join>[
            innerJoin(
              _db.appUsers,
              _db.appUsers.id.equalsExp(
                _db.trailerStatusChanges.changedByUserId,
              ),
            ),
          ])
          ..where(_db.trailerStatusChanges.trailerId.equals(trailerId))
          ..orderBy(<OrderingTerm>[
            OrderingTerm.desc(_db.trailerStatusChanges.changedAt),
            OrderingTerm.desc(_db.trailerStatusChanges.id),
          ]);
    return select.watch().map(
      (List<TypedResult> rows) => rows.map((TypedResult result) {
        final TrailerStatusChangeRow change = result.readTable(
          _db.trailerStatusChanges,
        );
        final AppUserRow user = result.readTable(_db.appUsers);
        return TrailerStatusChange(
          id: change.id,
          trailerId: change.trailerId,
          oldStatus: change.oldStatus,
          newStatus: change.newStatus,
          changedAt: change.changedAt,
          changedByUserId: user.id,
          changedByName: user.name,
          rentalContractId: change.rentalContractId,
        );
      }).toList(),
    );
  }

  JoinedSelectStatement<HasResultSet, dynamic> _joinedSelect() {
    return _db.select(_db.trailers).join(<Join>[
      innerJoin(
        _db.trailerTypes,
        _db.trailerTypes.id.equalsExp(_db.trailers.trailerTypeId),
      ),
    ]);
  }

  Future<Trailer> _requireTrailer(int id) async {
    final TypedResult? result =
        await (_joinedSelect()..where(_db.trailers.id.equals(id)))
            .getSingleOrNull();
    if (result == null) {
      throw const RepositoryException(RepositoryError.notFound);
    }
    return _mapResult(result);
  }

  Future<TrailerRow> _requireRow(int id) async {
    final TrailerRow? row = await (_db.select(
      _db.trailers,
    )..where(($TrailersTable t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) {
      throw const RepositoryException(RepositoryError.notFound);
    }
    return row;
  }

  Future<void> _ensureUnique(
    String internalCode,
    String licensePlate, {
    int? excludeId,
  }) async {
    final List<TrailerRow> rows =
        await (_db.select(_db.trailers)..where(
              ($TrailersTable t) =>
                  t.internalCode.equals(internalCode) |
                  t.licensePlate.equals(licensePlate),
            ))
            .get();
    for (final TrailerRow row in rows) {
      if (row.id == excludeId) {
        continue;
      }
      if (row.internalCode == internalCode) {
        throw const RepositoryException(RepositoryError.duplicateInternalCode);
      }
      throw const RepositoryException(RepositoryError.duplicateLicensePlate);
    }
  }

  Future<void> _write(int id, TrailersCompanion companion) {
    return (_db.update(
      _db.trailers,
    )..where(($TrailersTable t) => t.id.equals(id))).write(companion);
  }

  Future<void> _logStatusChange({
    required int trailerId,
    required TrailerStatus? oldStatus,
    required TrailerStatus newStatus,
    required int userId,
  }) {
    return _db
        .into(_db.trailerStatusChanges)
        .insert(
          TrailerStatusChangesCompanion.insert(
            trailerId: trailerId,
            oldStatus: Value<TrailerStatus?>(oldStatus),
            newStatus: newStatus,
            changedByUserId: userId,
          ),
        );
  }

  String _normalizePlate(String value) {
    return value.trim().toUpperCase().replaceAll(RegExp(r'\s+'), ' ');
  }

  Trailer _mapResult(TypedResult result) {
    final TrailerRow row = result.readTable(_db.trailers);
    final TrailerTypeRow type = result.readTable(_db.trailerTypes);
    return Trailer(
      id: row.id,
      internalCode: row.internalCode,
      licensePlate: row.licensePlate,
      type: TrailerType(id: type.id, name: type.name),
      status: row.status,
      location: TrailerLocation(
        address: row.locationAddress,
        latitude: row.locationLatitude,
        longitude: row.locationLongitude,
        updatedAt: row.locationUpdatedAt,
      ),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      archivedAt: row.archivedAt,
    );
  }
}

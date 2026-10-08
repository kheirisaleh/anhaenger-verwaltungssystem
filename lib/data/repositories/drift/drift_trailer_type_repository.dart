import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../models/trailer.dart';
import '../repository_exception.dart';
import '../trailer_type_repository.dart';

class DriftTrailerTypeRepository implements TrailerTypeRepository {
  DriftTrailerTypeRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<TrailerType>> watchAll() {
    final SimpleSelectStatement<$TrailerTypesTable, TrailerTypeRow> query =
        _db.select(_db.trailerTypes)
          ..orderBy(<OrderClauseGenerator<$TrailerTypesTable>>[
            ($TrailerTypesTable t) => OrderingTerm.asc(t.name),
          ]);
    return query.watch().map(
      (List<TrailerTypeRow> rows) => rows.map(_map).toList(),
    );
  }

  @override
  Future<TrailerType> create(String name) {
    return _db.transaction(() async {
      final String trimmed = name.trim();
      await _ensureUniqueName(trimmed);
      final int id = await _db
          .into(_db.trailerTypes)
          .insert(TrailerTypesCompanion.insert(name: trimmed));
      return _map(await _requireRow(id));
    });
  }

  @override
  Future<void> rename(int id, String name) {
    return _db.transaction(() async {
      final String trimmed = name.trim();
      await _requireRow(id);
      await _ensureUniqueName(trimmed, excludeId: id);
      await (_db.update(
        _db.trailerTypes,
      )..where(($TrailerTypesTable t) => t.id.equals(id))).write(
        TrailerTypesCompanion(
          name: Value<String>(trimmed),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    });
  }

  @override
  Future<void> delete(int id) {
    return _db.transaction(() async {
      await _requireRow(id);
      final TrailerRow? usedBy =
          await (_db.select(_db.trailers)
                ..where(($TrailersTable t) => t.trailerTypeId.equals(id))
                ..limit(1))
              .getSingleOrNull();
      if (usedBy != null) {
        throw const RepositoryException(RepositoryError.trailerTypeInUse);
      }
      await (_db.delete(
        _db.trailerTypes,
      )..where(($TrailerTypesTable t) => t.id.equals(id))).go();
    });
  }

  Future<TrailerTypeRow> _requireRow(int id) async {
    final TrailerTypeRow? row = await (_db.select(
      _db.trailerTypes,
    )..where(($TrailerTypesTable t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) {
      throw const RepositoryException(RepositoryError.notFound);
    }
    return row;
  }

  Future<void> _ensureUniqueName(String name, {int? excludeId}) async {
    final List<TrailerTypeRow> rows = await (_db.select(
      _db.trailerTypes,
    )..where(($TrailerTypesTable t) => t.name.equals(name))).get();
    if (rows.any((TrailerTypeRow row) => row.id != excludeId)) {
      throw const RepositoryException(RepositoryError.duplicateName);
    }
  }

  TrailerType _map(TrailerTypeRow row) {
    return TrailerType(id: row.id, name: row.name);
  }
}

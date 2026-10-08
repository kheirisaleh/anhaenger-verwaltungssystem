import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../models/app_user.dart';
import '../repository_exception.dart';
import '../user_repository.dart';

class DriftUserRepository implements UserRepository {
  DriftUserRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<AppUser>> watchAll({bool includeInactive = false}) {
    final SimpleSelectStatement<$AppUsersTable, AppUserRow> query =
        _db.select(_db.appUsers)
          ..orderBy(<OrderClauseGenerator<$AppUsersTable>>[
            ($AppUsersTable t) => OrderingTerm.asc(t.name),
          ]);
    if (!includeInactive) {
      query.where(($AppUsersTable t) => t.isActive.equals(true));
    }
    return query.watch().map(
      (List<AppUserRow> rows) => rows.map(_map).toList(),
    );
  }

  @override
  Future<AppUser> create(String name) {
    return _db.transaction(() async {
      final String trimmed = name.trim();
      await _ensureUniqueName(trimmed);
      final int id = await _db
          .into(_db.appUsers)
          .insert(AppUsersCompanion.insert(name: trimmed));
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
        _db.appUsers,
      )..where(($AppUsersTable t) => t.id.equals(id))).write(
        AppUsersCompanion(
          name: Value<String>(trimmed),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    });
  }

  @override
  Future<void> setActive(int id, {required bool isActive}) {
    return _db.transaction(() async {
      await _requireRow(id);
      await (_db.update(
        _db.appUsers,
      )..where(($AppUsersTable t) => t.id.equals(id))).write(
        AppUsersCompanion(
          isActive: Value<bool>(isActive),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    });
  }

  Future<AppUserRow> _requireRow(int id) async {
    final AppUserRow? row = await (_db.select(
      _db.appUsers,
    )..where(($AppUsersTable t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) {
      throw const RepositoryException(RepositoryError.notFound);
    }
    return row;
  }

  Future<void> _ensureUniqueName(String name, {int? excludeId}) async {
    final List<AppUserRow> rows = await (_db.select(
      _db.appUsers,
    )..where(($AppUsersTable t) => t.name.equals(name))).get();
    if (rows.any((AppUserRow row) => row.id != excludeId)) {
      throw const RepositoryException(RepositoryError.duplicateName);
    }
  }

  AppUser _map(AppUserRow row) {
    return AppUser(id: row.id, name: row.name, isActive: row.isActive);
  }
}

import 'dart:io';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../models/photo.dart';
import '../../sources/photo_file_store.dart';
import '../photo_repository.dart';
import '../repository_exception.dart';

class DriftPhotoRepository implements PhotoRepository {
  DriftPhotoRepository(this._db, this._files);

  final AppDatabase _db;
  final PhotoFileStore _files;

  @override
  Stream<List<Photo>> watchFor(PhotoOwner owner) {
    final SimpleSelectStatement<$PhotosTable, PhotoRow> select =
        _db.select(_db.photos)
          ..where(($PhotosTable t) => _ownerFilter(t, owner))
          ..orderBy(<OrderClauseGenerator<$PhotosTable>>[
            ($PhotosTable t) => OrderingTerm.asc(t.sortOrder),
            ($PhotosTable t) => OrderingTerm.asc(t.id),
          ]);
    return select.watch().map(
      (List<PhotoRow> rows) => rows.map(_map).toList(),
    );
  }

  @override
  Future<Photo> add(PhotoOwner owner, File source) async {
    final String relativePath = await _files.copyIn(owner, source);
    try {
      return await _db.transaction(() async {
        final List<PhotoRow> existing = await (_db.select(
          _db.photos,
        )..where(($PhotosTable t) => _ownerFilter(t, owner))).get();
        final int nextOrder =
            existing.fold<int>(
              -1,
              (int highest, PhotoRow row) =>
                  row.sortOrder > highest ? row.sortOrder : highest,
            ) +
            1;
        final int id = await _db
            .into(_db.photos)
            .insert(
              PhotosCompanion.insert(
                trailerId: Value<int?>(
                  owner is TrailerPhotoOwner ? owner.id : null,
                ),
                damageRecordId: Value<int?>(
                  owner is DamagePhotoOwner ? owner.id : null,
                ),
                filePath: relativePath,
                sortOrder: Value<int>(nextOrder),
              ),
            );
        return _map(await _requireRow(id));
      });
    } catch (_) {
      await _files.delete(relativePath);
      rethrow;
    }
  }

  @override
  Future<void> replace(int photoId, File source) async {
    final PhotoRow row = await _requireRow(photoId);
    final PhotoOwner owner = _ownerOf(row);
    final String relativePath = await _files.copyIn(owner, source);
    try {
      await (_db.update(_db.photos)
            ..where(($PhotosTable t) => t.id.equals(photoId)))
          .write(PhotosCompanion(filePath: Value<String>(relativePath)));
    } catch (_) {
      await _files.delete(relativePath);
      rethrow;
    }
    await _files.delete(row.filePath);
  }

  @override
  Future<void> delete(int photoId) async {
    final PhotoRow row = await _requireRow(photoId);
    await (_db.delete(
      _db.photos,
    )..where(($PhotosTable t) => t.id.equals(photoId))).go();
    await _files.delete(row.filePath);
  }

  @override
  File fileOf(Photo photo) => _files.resolve(photo.filePath);

  Expression<bool> _ownerFilter($PhotosTable table, PhotoOwner owner) {
    return switch (owner) {
      TrailerPhotoOwner(:final int id) => table.trailerId.equals(id),
      DamagePhotoOwner(:final int id) => table.damageRecordId.equals(id),
    };
  }

  PhotoOwner _ownerOf(PhotoRow row) {
    final int? trailerId = row.trailerId;
    if (trailerId != null) {
      return TrailerPhotoOwner(trailerId);
    }
    return DamagePhotoOwner(row.damageRecordId!);
  }

  Future<PhotoRow> _requireRow(int id) async {
    final PhotoRow? row = await (_db.select(
      _db.photos,
    )..where(($PhotosTable t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) {
      throw const RepositoryException(RepositoryError.notFound);
    }
    return row;
  }

  Photo _map(PhotoRow row) {
    return Photo(
      id: row.id,
      trailerId: row.trailerId,
      damageRecordId: row.damageRecordId,
      filePath: row.filePath,
      sortOrder: row.sortOrder,
      createdAt: row.createdAt,
    );
  }
}

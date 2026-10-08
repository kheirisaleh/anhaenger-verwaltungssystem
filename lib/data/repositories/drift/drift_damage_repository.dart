import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../models/damage_record.dart';
import '../../models/enums.dart';
import '../../sources/photo_file_store.dart';
import '../damage_repository.dart';
import '../repository_exception.dart';

class DriftDamageRepository implements DamageRepository {
  DriftDamageRepository(this._db, this._files);

  final AppDatabase _db;
  final PhotoFileStore _files;

  @override
  Stream<List<DamageRecord>> watchForTrailer(
    int trailerId, {
    DamageFilter filter = const DamageFilter(),
  }) {
    return watchAll(
      filter: DamageFilter(
        trailerId: trailerId,
        damageType: filter.damageType,
        from: filter.from,
        until: filter.until,
      ),
    );
  }

  @override
  Stream<List<DamageRecord>> watchAll({
    DamageFilter filter = const DamageFilter(),
  }) {
    final SimpleSelectStatement<$DamageRecordsTable, DamageRecordRow> select =
        _db.select(_db.damageRecords)
          ..orderBy(<OrderClauseGenerator<$DamageRecordsTable>>[
            ($DamageRecordsTable t) => OrderingTerm.desc(t.eventDate),
            ($DamageRecordsTable t) => OrderingTerm.desc(t.id),
          ]);
    final int? trailerId = filter.trailerId;
    if (trailerId != null) {
      select.where(
        ($DamageRecordsTable t) => t.trailerId.equals(trailerId),
      );
    }
    final DamageType? damageType = filter.damageType;
    if (damageType != null) {
      select.where(
        ($DamageRecordsTable t) => t.damageType.equalsValue(damageType),
      );
    }
    final DateTime? from = filter.from;
    if (from != null) {
      select.where(
        ($DamageRecordsTable t) =>
            t.eventDate.isBiggerOrEqualValue(_dateOnly(from)),
      );
    }
    final DateTime? until = filter.until;
    if (until != null) {
      select.where(
        ($DamageRecordsTable t) =>
            t.eventDate.isSmallerOrEqualValue(_dateOnly(until)),
      );
    }
    return select.watch().map(
      (List<DamageRecordRow> rows) => rows.map(_map).toList(),
    );
  }

  @override
  Future<DamageRecord> create(DamageRecordDraft draft, {required int userId}) {
    return _db.transaction(() async {
      _validate(draft);
      final int id = await _db
          .into(_db.damageRecords)
          .insert(
            DamageRecordsCompanion.insert(
              trailerId: draft.trailerId,
              eventDate: _dateOnly(draft.eventDate),
              description: draft.description.trim(),
              damageType: draft.damageType,
              causedBy: draft.causedBy,
              customerId: Value<int?>(_customerIdOf(draft)),
              rentalContractId: Value<int?>(draft.rentalContractId),
              costCents: Value<int?>(draft.costCents),
              createdByUserId: userId,
            ),
          );
      return _map(await _requireRow(id));
    });
  }

  @override
  Future<void> update(int id, DamageRecordDraft draft) {
    return _db.transaction(() async {
      await _requireRow(id);
      _validate(draft);
      await (_db.update(
        _db.damageRecords,
      )..where(($DamageRecordsTable t) => t.id.equals(id))).write(
        DamageRecordsCompanion(
          trailerId: Value<int>(draft.trailerId),
          eventDate: Value<DateTime>(_dateOnly(draft.eventDate)),
          description: Value<String>(draft.description.trim()),
          damageType: Value<DamageType>(draft.damageType),
          causedBy: Value<DamageCause>(draft.causedBy),
          customerId: Value<int?>(_customerIdOf(draft)),
          rentalContractId: Value<int?>(draft.rentalContractId),
          costCents: Value<int?>(draft.costCents),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    });
  }

  @override
  Future<void> delete(int id) async {
    final List<String> filePaths = await _db.transaction(() async {
      await _requireRow(id);
      final List<PhotoRow> photos = await (_db.select(
        _db.photos,
      )..where(($PhotosTable t) => t.damageRecordId.equals(id))).get();
      await (_db.delete(
        _db.damageRecords,
      )..where(($DamageRecordsTable t) => t.id.equals(id))).go();
      return photos.map((PhotoRow photo) => photo.filePath).toList();
    });
    for (final String path in filePaths) {
      await _files.delete(path);
    }
  }

  void _validate(DamageRecordDraft draft) {
    final int? cost = draft.costCents;
    if (cost != null && cost < 0) {
      throw const RepositoryException(RepositoryError.invalidAmount);
    }
  }

  int? _customerIdOf(DamageRecordDraft draft) {
    return draft.causedBy == DamageCause.customer ? draft.customerId : null;
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  Future<DamageRecordRow> _requireRow(int id) async {
    final DamageRecordRow? row = await (_db.select(
      _db.damageRecords,
    )..where(($DamageRecordsTable t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) {
      throw const RepositoryException(RepositoryError.notFound);
    }
    return row;
  }

  DamageRecord _map(DamageRecordRow row) {
    return DamageRecord(
      id: row.id,
      trailerId: row.trailerId,
      eventDate: row.eventDate,
      description: row.description,
      damageType: row.damageType,
      causedBy: row.causedBy,
      customerId: row.customerId,
      rentalContractId: row.rentalContractId,
      costCents: row.costCents,
      createdByUserId: row.createdByUserId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}

import '../models/damage_record.dart';

abstract interface class DamageRepository {
  Stream<List<DamageRecord>> watchAll({
    DamageFilter filter = const DamageFilter(),
  });

  Stream<List<DamageRecord>> watchForTrailer(
    int trailerId, {
    DamageFilter filter = const DamageFilter(),
  });

  Future<DamageRecord> create(DamageRecordDraft draft, {required int userId});

  Future<void> update(int id, DamageRecordDraft draft);

  Future<void> delete(int id);
}

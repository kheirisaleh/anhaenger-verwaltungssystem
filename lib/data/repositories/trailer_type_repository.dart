import '../models/trailer.dart';

abstract interface class TrailerTypeRepository {
  Stream<List<TrailerType>> watchAll();

  Future<TrailerType> create(String name);

  Future<void> rename(int id, String name);

  Future<void> delete(int id);
}

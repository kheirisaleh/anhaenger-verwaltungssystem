import '../models/enums.dart';
import '../models/trailer.dart';

class TrailerQuery {
  const TrailerQuery({this.status, this.search, this.includeArchived = false});

  final TrailerStatus? status;
  final String? search;
  final bool includeArchived;
}

abstract interface class TrailerRepository {
  Stream<List<Trailer>> watchAll({TrailerQuery query = const TrailerQuery()});

  Stream<Trailer?> watchById(int id);

  Future<Trailer> create(TrailerDraft draft, {required int userId});

  Future<void> update(int id, TrailerDraft draft);

  Future<void> changeStatus(
    int id,
    TrailerStatus status, {
    required int userId,
  });

  Future<void> updateLocation(int id, TrailerLocation location);

  Future<void> archive(int id);

  Future<void> restore(int id);

  Stream<List<TrailerStatusChange>> watchStatusHistory(int trailerId);
}

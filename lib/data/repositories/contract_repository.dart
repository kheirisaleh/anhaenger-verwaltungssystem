import '../models/enums.dart';
import '../models/rental_contract.dart';

class ContractQuery {
  const ContractQuery({this.status, this.customerId, this.trailerId});

  final ContractStatus? status;
  final int? customerId;
  final int? trailerId;
}

abstract interface class ContractRepository {
  Stream<List<RentalContract>> watchAll({
    ContractQuery query = const ContractQuery(),
  });

  Stream<RentalContract?> watchById(int id);

  Future<RentalContract> create(
    RentalContractDraft draft, {
    required int userId,
  });

  Future<void> update(int id, RentalContractDraft draft);

  Future<void> handOver(int id, {required int userId});

  Future<void> completeReturn(int id, {required int userId});

  Future<void> cancel(int id);
}

import 'package:flutter/foundation.dart';

import '../../../data/models/enums.dart';
import '../../../data/models/rental_contract.dart';
import '../../../data/repositories/contract_repository.dart';

class ContractListController extends ChangeNotifier {
  ContractListController(this._repository, {this.customerId, this.trailerId}) {
    _contracts = _query();
  }

  final ContractRepository _repository;
  final int? customerId;
  final int? trailerId;
  late Stream<List<RentalContract>> _contracts;
  ContractStatus? _status;

  Stream<List<RentalContract>> get contracts => _contracts;
  ContractStatus? get status => _status;
  bool get hasFilter => _status != null;

  void setStatus(ContractStatus? status) {
    _status = status;
    _contracts = _query();
    notifyListeners();
  }

  Stream<List<RentalContract>> _query() {
    return _repository.watchAll(
      query: ContractQuery(
        status: _status,
        customerId: customerId,
        trailerId: trailerId,
      ),
    );
  }
}

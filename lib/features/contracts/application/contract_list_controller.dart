import 'package:flutter/foundation.dart';

import '../../../data/models/enums.dart';
import '../../../data/models/rental_contract.dart';
import '../../../data/repositories/contract_repository.dart';

enum ContractFilter {
  all,
  attention,
  overdue,
  planned,
  active,
  completed,
  cancelled,
}

class ContractListController extends ChangeNotifier {
  ContractListController(
    this._repository, {
    this.customerId,
    this.trailerId,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now {
    _contracts = _repository.watchAll(
      query: ContractQuery(customerId: customerId, trailerId: trailerId),
    );
  }

  final ContractRepository _repository;
  final int? customerId;
  final int? trailerId;
  final DateTime Function() _now;
  late final Stream<List<RentalContract>> _contracts;
  ContractFilter _filter = ContractFilter.all;
  String _search = '';

  Stream<List<RentalContract>> get contracts => _contracts;
  ContractFilter get filter => _filter;
  bool get hasFilter =>
      _filter != ContractFilter.all || _search.trim().isNotEmpty;

  void setFilter(ContractFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  void setSearch(String search) {
    _search = search;
    notifyListeners();
  }

  List<RentalContract> matchingSearch(
    List<RentalContract> all,
    String Function(RentalContract contract) describe,
  ) {
    final String term = _search.trim().toLowerCase();
    if (term.isEmpty) {
      return all;
    }
    return all
        .where(
          (RentalContract c) =>
              '#${c.id} ${describe(c)}'.toLowerCase().contains(term),
        )
        .toList();
  }

  bool matchesFilter(RentalContract contract, ContractFilter filter) {
    final DateTime now = _now();
    return switch (filter) {
      ContractFilter.all => true,
      ContractFilter.attention => contract.needsAttention(now),
      ContractFilter.overdue => contract.isOverdue(now),
      ContractFilter.planned => contract.status == ContractStatus.planned,
      ContractFilter.active => contract.status == ContractStatus.active,
      ContractFilter.completed => contract.status == ContractStatus.completed,
      ContractFilter.cancelled => contract.status == ContractStatus.cancelled,
    };
  }

  int count(List<RentalContract> searched, ContractFilter filter) {
    return searched
        .where((RentalContract c) => matchesFilter(c, filter))
        .length;
  }

  List<RentalContract> visible(List<RentalContract> searched) {
    return searched
        .where((RentalContract c) => matchesFilter(c, _filter))
        .toList();
  }

  DateTime now() => _now();
}

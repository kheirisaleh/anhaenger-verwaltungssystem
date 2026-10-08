import 'package:flutter/foundation.dart';

import '../../../data/models/customer.dart';
import '../../../data/repositories/customer_repository.dart';

class CustomerListController extends ChangeNotifier {
  CustomerListController(this._repository) {
    _customers = _query();
  }

  final CustomerRepository _repository;
  late Stream<List<Customer>> _customers;
  String _search = '';
  bool _includeArchived = false;

  Stream<List<Customer>> get customers => _customers;
  bool get includeArchived => _includeArchived;
  bool get hasFilter => _search.trim().isNotEmpty || _includeArchived;

  void setSearch(String search) {
    _search = search;
    _refresh();
  }

  void setIncludeArchived(bool value) {
    _includeArchived = value;
    _refresh();
  }

  void _refresh() {
    _customers = _query();
    notifyListeners();
  }

  Stream<List<Customer>> _query() {
    return _repository.watchAll(
      search: _search,
      includeArchived: _includeArchived,
    );
  }
}

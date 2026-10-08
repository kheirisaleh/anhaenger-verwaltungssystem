import 'package:flutter/foundation.dart';

import '../../../data/models/enums.dart';
import '../../../data/models/trailer.dart';
import '../../../data/repositories/trailer_repository.dart';

class TrailerListController extends ChangeNotifier {
  TrailerListController(this._repository) {
    _trailers = _query();
  }

  final TrailerRepository _repository;
  late Stream<List<Trailer>> _trailers;
  TrailerStatus? _status;
  String _search = '';
  bool _includeArchived = false;

  Stream<List<Trailer>> get trailers => _trailers;
  TrailerStatus? get status => _status;
  String get search => _search;
  bool get includeArchived => _includeArchived;
  bool get hasFilter =>
      _status != null || _search.trim().isNotEmpty || _includeArchived;

  void setStatus(TrailerStatus? status) {
    _status = status;
    _refresh();
  }

  void setSearch(String search) {
    _search = search;
    _refresh();
  }

  void setIncludeArchived(bool value) {
    _includeArchived = value;
    _refresh();
  }

  void _refresh() {
    _trailers = _query();
    notifyListeners();
  }

  Stream<List<Trailer>> _query() {
    return _repository.watchAll(
      query: TrailerQuery(
        status: _status,
        search: _search,
        includeArchived: _includeArchived,
      ),
    );
  }
}

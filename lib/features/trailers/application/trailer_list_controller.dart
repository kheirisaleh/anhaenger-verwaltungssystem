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
  bool get includeArchived => _includeArchived;
  bool get hasFilter =>
      _status != null || _search.trim().isNotEmpty || _includeArchived;

  void setStatus(TrailerStatus? status) {
    _status = status;
    notifyListeners();
  }

  void setSearch(String search) {
    _search = search;
    notifyListeners();
  }

  void setIncludeArchived(bool value) {
    _includeArchived = value;
    _trailers = _query();
    notifyListeners();
  }

  List<Trailer> matchingSearch(List<Trailer> all) {
    final String term = _search.trim().toLowerCase();
    if (term.isEmpty) {
      return all;
    }
    return all
        .where(
          (Trailer t) =>
              t.internalCode.toLowerCase().contains(term) ||
              t.licensePlate.toLowerCase().contains(term) ||
              t.type.name.toLowerCase().contains(term) ||
              (t.location.address ?? '').toLowerCase().contains(term),
        )
        .toList();
  }

  List<Trailer> visible(List<Trailer> all) {
    final TrailerStatus? status = _status;
    final List<Trailer> matches = matchingSearch(all);
    if (status == null) {
      return matches;
    }
    return matches.where((Trailer t) => t.status == status).toList();
  }

  Map<TrailerStatus, int> counts(List<Trailer> all) {
    final List<Trailer> matches = matchingSearch(all);
    return <TrailerStatus, int>{
      for (final TrailerStatus status in TrailerStatus.values)
        status: matches.where((Trailer t) => t.status == status).length,
    };
  }

  Stream<List<Trailer>> _query() {
    return _repository.watchAll(
      query: TrailerQuery(includeArchived: _includeArchived),
    );
  }
}

import 'package:flutter/foundation.dart';

import '../../../data/models/damage_record.dart';
import '../../../data/models/enums.dart';
import '../../../data/repositories/damage_repository.dart';

enum DamagePeriod { all, last30Days, last12Months, thisYear }

class DamageListController extends ChangeNotifier {
  DamageListController(
    this._repository, {
    this.trailerId,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now {
    _damages = _query();
  }

  final DamageRepository _repository;
  final int? trailerId;
  final DateTime Function() _now;
  late Stream<List<DamageRecord>> _damages;
  DamageType? _damageType;
  DamagePeriod _period = DamagePeriod.all;

  Stream<List<DamageRecord>> get damages => _damages;
  DamageType? get damageType => _damageType;
  DamagePeriod get period => _period;
  bool get hasFilter => _damageType != null || _period != DamagePeriod.all;

  void setDamageType(DamageType? type) {
    _damageType = type;
    _refresh();
  }

  void setPeriod(DamagePeriod? period) {
    _period = period ?? DamagePeriod.all;
    _refresh();
  }

  DamageFilter get filter {
    final DateTime now = _now();
    final DateTime? from = switch (_period) {
      DamagePeriod.all => null,
      DamagePeriod.last30Days => now.subtract(const Duration(days: 30)),
      DamagePeriod.last12Months => DateTime(now.year - 1, now.month, now.day),
      DamagePeriod.thisYear => DateTime(now.year),
    };
    return DamageFilter(
      trailerId: trailerId,
      damageType: _damageType,
      from: from,
    );
  }

  void _refresh() {
    _damages = _query();
    notifyListeners();
  }

  Stream<List<DamageRecord>> _query() {
    return _repository.watchAll(filter: filter);
  }
}

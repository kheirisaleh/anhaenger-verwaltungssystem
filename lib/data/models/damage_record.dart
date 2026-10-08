import 'enums.dart';

class DamageRecord {
  const DamageRecord({
    required this.id,
    required this.trailerId,
    required this.eventDate,
    required this.description,
    required this.damageType,
    required this.causedBy,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.customerId,
    this.rentalContractId,
    this.costCents,
  });

  final int id;
  final int trailerId;
  final DateTime eventDate;
  final String description;
  final DamageType damageType;
  final DamageCause causedBy;
  final int? customerId;
  final int? rentalContractId;
  final int? costCents;
  final int createdByUserId;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class DamageRecordDraft {
  const DamageRecordDraft({
    required this.trailerId,
    required this.eventDate,
    required this.description,
    required this.damageType,
    required this.causedBy,
    this.customerId,
    this.rentalContractId,
    this.costCents,
  });

  final int trailerId;
  final DateTime eventDate;
  final String description;
  final DamageType damageType;
  final DamageCause causedBy;
  final int? customerId;
  final int? rentalContractId;
  final int? costCents;
}

class DamageFilter {
  const DamageFilter({this.damageType, this.from, this.until});

  final DamageType? damageType;
  final DateTime? from;
  final DateTime? until;
}

import 'enums.dart';

class RentalContract {
  const RentalContract({
    required this.id,
    required this.customerId,
    required this.trailerId,
    required this.startAt,
    required this.endAt,
    required this.pickupLocation,
    required this.returnLocation,
    required this.priceCents,
    required this.status,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.handedOverAt,
    this.returnedAt,
  });

  final int id;
  final int customerId;
  final int trailerId;
  final DateTime startAt;
  final DateTime endAt;
  final String pickupLocation;
  final String returnLocation;
  final int priceCents;
  final ContractStatus status;
  final DateTime? handedOverAt;
  final DateTime? returnedAt;
  final int createdByUserId;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isEditable => status == ContractStatus.planned;

  Duration get duration => endAt.difference(startAt);
}

class RentalContractDraft {
  const RentalContractDraft({
    required this.customerId,
    required this.trailerId,
    required this.startAt,
    required this.endAt,
    required this.pickupLocation,
    required this.returnLocation,
    required this.priceCents,
  });

  final int customerId;
  final int trailerId;
  final DateTime startAt;
  final DateTime endAt;
  final String pickupLocation;
  final String returnLocation;
  final int priceCents;
}

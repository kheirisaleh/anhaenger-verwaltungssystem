import 'enums.dart';

class TrailerType {
  const TrailerType({required this.id, required this.name});

  final int id;
  final String name;
}

class TrailerLocation {
  const TrailerLocation({
    this.address,
    this.latitude,
    this.longitude,
    this.updatedAt,
  });

  final String? address;
  final double? latitude;
  final double? longitude;
  final DateTime? updatedAt;

  bool get hasCoordinates => latitude != null && longitude != null;

  bool get isEmpty => address == null && !hasCoordinates;
}

class Trailer {
  const Trailer({
    required this.id,
    required this.internalCode,
    required this.licensePlate,
    required this.type,
    required this.status,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });

  final int id;
  final String internalCode;
  final String licensePlate;
  final TrailerType type;
  final TrailerStatus status;
  final TrailerLocation location;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;

  bool get isArchived => archivedAt != null;
}

class TrailerDraft {
  const TrailerDraft({
    required this.internalCode,
    required this.licensePlate,
    required this.typeId,
  });

  final String internalCode;
  final String licensePlate;
  final int typeId;
}

class TrailerStatusChange {
  const TrailerStatusChange({
    required this.id,
    required this.trailerId,
    required this.newStatus,
    required this.changedAt,
    required this.changedByUserId,
    required this.changedByName,
    this.oldStatus,
    this.rentalContractId,
  });

  final int id;
  final int trailerId;
  final TrailerStatus? oldStatus;
  final TrailerStatus newStatus;
  final DateTime changedAt;
  final int changedByUserId;
  final String changedByName;
  final int? rentalContractId;
}

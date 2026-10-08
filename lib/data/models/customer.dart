class Customer {
  const Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.street,
    required this.postalCode,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    this.licenseNumber,
    this.archivedAt,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String street;
  final String postalCode;
  final String city;
  final String? licenseNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;

  String get fullName => '$firstName $lastName';

  bool get isArchived => archivedAt != null;
}

class CustomerDraft {
  const CustomerDraft({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.street,
    required this.postalCode,
    required this.city,
    this.licenseNumber,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String street;
  final String postalCode;
  final String city;
  final String? licenseNumber;
}

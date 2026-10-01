import '../../core/constants/app_strings.dart';

enum TrailerStatus {
  available(AppStrings.statusAvailable),
  rented(AppStrings.statusRented),
  maintenance(AppStrings.statusMaintenance),
  blocked(AppStrings.statusBlocked);

  const TrailerStatus(this.label);

  final String label;
}

enum ContractStatus {
  active(AppStrings.contractStatusActive),
  completed(AppStrings.contractStatusCompleted),
  cancelled(AppStrings.contractStatusCancelled);

  const ContractStatus(this.label);

  final String label;
}

enum DamageType {
  accident('Unfall'),
  vandalism('Vandalismus'),
  wear('Verschleiss'),
  other('Sonstiges');

  const DamageType(this.label);

  final String label;
}

enum DamageCause {
  customer('Kunde'),
  internal('Intern'),
  unknown('Unbekannt');

  const DamageCause(this.label);

  final String label;
}

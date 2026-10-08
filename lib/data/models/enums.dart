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
  planned(AppStrings.contractStatusPlanned),
  active(AppStrings.contractStatusActive),
  completed(AppStrings.contractStatusCompleted),
  cancelled(AppStrings.contractStatusCancelled);

  const ContractStatus(this.label);

  final String label;

  bool get blocksTrailer =>
      this == ContractStatus.planned || this == ContractStatus.active;
}

enum DamageType {
  accident(AppStrings.damageTypeAccident),
  vandalism(AppStrings.damageTypeVandalism),
  wear(AppStrings.damageTypeWear),
  other(AppStrings.damageTypeOther);

  const DamageType(this.label);

  final String label;
}

enum DamageCause {
  customer(AppStrings.damageCauseCustomer),
  internal(AppStrings.damageCauseInternal),
  unknown(AppStrings.damageCauseUnknown);

  const DamageCause(this.label);

  final String label;
}

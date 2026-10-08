import '../../core/constants/app_strings.dart';

enum RepositoryError {
  notFound(AppStrings.errorNotFound),
  duplicateName(AppStrings.errorDuplicateName),
  duplicateInternalCode(AppStrings.errorDuplicateInternalCode),
  duplicateLicensePlate(AppStrings.errorDuplicateLicensePlate),
  rentedStatusManual(AppStrings.errorRentedStatusManual),
  statusChangeNotAllowed(AppStrings.errorStatusChangeNotAllowed),
  trailerNotAvailable(AppStrings.errorTrailerNotAvailable),
  trailerArchived(AppStrings.errorTrailerArchived),
  trailerHasOpenContracts(AppStrings.errorTrailerHasOpenContracts),
  trailerTypeInUse(AppStrings.errorTrailerTypeInUse),
  customerArchived(AppStrings.errorCustomerArchived),
  customerHasOpenContracts(AppStrings.errorCustomerHasOpenContracts),
  invalidDateRange(AppStrings.validationDateRange),
  invalidAmount(AppStrings.errorInvalidPrice),
  contractOverlap(AppStrings.errorContractOverlap),
  contractNotEditable(AppStrings.errorContractNotEditable),
  invalidContractTransition(AppStrings.errorContractTransition);

  const RepositoryError(this.message);

  final String message;
}

class RepositoryException implements Exception {
  const RepositoryException(this.error);

  final RepositoryError error;

  String get message => error.message;

  @override
  String toString() => 'RepositoryException(${error.name})';
}

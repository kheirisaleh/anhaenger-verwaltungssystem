import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_messages.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import '../../../core/formatting/app_formats.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/rental_contract.dart';
import '../../../data/models/trailer.dart';
import '../../../data/repositories/trailer_repository.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/file_dialogs.dart';
import '../../../shared/lookup_builder.dart';
import 'contract_table.dart';

class ContractsPage extends StatelessWidget {
  const ContractsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageScaffold(
      title: AppStrings.navContracts,
      actions: <Widget>[
        AppButton(
          label: AppStrings.actionExport,
          icon: AppIcons.export,
          onPressed: () => _export(context),
        ),
      ],
      content: const ContractTable(),
    );
  }

  Future<void> _export(BuildContext context) async {
    final AppDependencies dependencies = AppScope.of(context);
    final List<RentalContract> contracts = await dependencies.contracts
        .watchAll()
        .first;
    final List<Customer> customers = await dependencies.customers
        .watchAll(includeArchived: true)
        .first;
    final List<Trailer> trailers = await dependencies.trailers
        .watchAll(query: const TrailerQuery(includeArchived: true))
        .first;
    final Lookups lookups = Lookups(customers: customers, trailers: trailers);
    final List<List<String>> rows = <List<String>>[
      <String>[
        AppStrings.fieldNumber,
        AppStrings.fieldCustomer,
        AppStrings.fieldTrailer,
        AppStrings.fieldStartAt,
        AppStrings.fieldEndAt,
        AppStrings.fieldPickupLocation,
        AppStrings.fieldReturnLocation,
        AppStrings.fieldPrice,
        AppStrings.fieldStatus,
      ],
      for (final RentalContract contract in contracts)
        <String>[
          '${contract.id}',
          lookups.customerName(contract.customerId),
          lookups.trailerName(contract.trailerId),
          AppFormats.dateTime(contract.startAt),
          AppFormats.dateTime(contract.endAt),
          contract.pickupLocation,
          contract.returnLocation,
          AppFormats.currencyFromCents(contract.priceCents),
          contract.status.label,
        ],
    ];
    try {
      final File? file = await FileDialogs.saveCsv(AppStrings.exportContractsFile, rows);
      if (file != null && context.mounted) {
        AppMessages.success(context, AppStrings.exportDone);
      }
    } on FileSystemException {
      if (context.mounted) {
        AppMessages.error(context, AppStrings.errorFile);
      }
    }
  }
}

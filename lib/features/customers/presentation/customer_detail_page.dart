import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_card.dart';
import '../../../core/design/widgets/app_charts.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/formatting/app_formats.dart';
import '../../../data/models/customer.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/run_action.dart';
import '../../../shared/scoped_navigation.dart';
import '../../contracts/presentation/contract_form_dialog.dart';
import '../../contracts/presentation/contract_table.dart';
import 'customer_form_dialog.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({super.key, required this.customerId});

  final int customerId;

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  Stream<Customer?>? _customer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _customer ??= AppScope.of(context).customers.watchById(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Customer?>(
      stream: _customer,
      builder: (BuildContext context, AsyncSnapshot<Customer?> snapshot) {
        final Customer? customer = snapshot.data;
        if (snapshot.hasError || customer == null) {
          return AppPageScaffold(
            title: AppStrings.navCustomers,
            onBack: () => Navigator.of(context).pop(),
            content: snapshot.hasError
                ? const AppErrorState()
                : const AppLoadingState(),
          );
        }
        final String? license = customer.licenseNumber;
        return AppPageScaffold(
          title: customer.isArchived
              ? '${customer.fullName} (${AppStrings.archived})'
              : customer.fullName,
          onBack: () => Navigator.of(context).pop(),
          actions: <Widget>[
            AppButton(
              label: AppStrings.contractCreate,
              icon: AppIcons.rent,
              variant: AppButtonVariant.primary,
              onPressed: customer.isArchived
                  ? null
                  : () => _createContract(context, customer),
            ),
            AppButton(
              label: AppStrings.actionEdit,
              icon: AppIcons.edit,
              onPressed: () => _edit(context, customer),
            ),
            if (customer.isArchived)
              AppButton(
                label: AppStrings.actionRestore,
                icon: AppIcons.restore,
                onPressed: () => runAction(
                  context,
                  () => AppScope.of(context).customers.restore(customer.id),
                  successMessage: AppStrings.restored,
                ),
              ),
          ],
          content: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: AppCard(
                    title: AppStrings.sectionContracts,
                    child: ContractTable(
                      customerId: customer.id,
                      shrinkWrap: true,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                SizedBox(
                  width: AppSizes.detailSidebarWidth,
                  child: AppCard(
                    title: AppStrings.sectionContactData,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppKeyValue(
                          label: AppStrings.fieldEmail,
                          value: customer.email,
                        ),
                        AppKeyValue(
                          label: AppStrings.fieldPhone,
                          value: customer.phone,
                        ),
                        AppKeyValue(
                          label: AppStrings.fieldAddress,
                          value:
                              '${customer.street}\n'
                              '${customer.postalCode} ${customer.city}',
                        ),
                        AppKeyValue(
                          label: AppStrings.fieldLicenseNumber,
                          value: license ?? AppStrings.none,
                        ),
                        AppKeyValue(
                          label: AppStrings.fieldCreatedAt,
                          value: AppFormats.date(customer.createdAt),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _createContract(BuildContext context, Customer customer) async {
    final Object? saved = await showScopedDialog<Object>(
      context,
      (BuildContext context) => ContractFormDialog(customerId: customer.id),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
  }

  Future<void> _edit(BuildContext context, Customer customer) async {
    final Object? saved = await showScopedDialog<Object>(
      context,
      (BuildContext context) => CustomerFormDialog(customer: customer),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
  }
}

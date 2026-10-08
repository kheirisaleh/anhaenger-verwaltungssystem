import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_checkbox.dart';
import '../../../core/design/widgets/app_data_table.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_icon_button.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import '../../../core/design/widgets/app_search_field.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/design/app_typography.dart';
import '../../../data/models/customer.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/run_action.dart';
import '../../../shared/scoped_navigation.dart';
import '../../contracts/presentation/contract_form_dialog.dart';
import '../application/customer_list_controller.dart';
import 'customer_detail_page.dart';
import 'customer_form_dialog.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  CustomerListController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= CustomerListController(AppScope.of(context).customers);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CustomerListController controller = _controller!;
    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) => AppPageScaffold(
        title: AppStrings.navCustomers,
        actions: <Widget>[
          AppButton(
            label: AppStrings.customerCreate,
            icon: AppIcons.add,
            variant: AppButtonVariant.primary,
            onPressed: () => _edit(context),
          ),
        ],
        filterBar: Row(
          children: <Widget>[
            Expanded(
              child: AppSearchField(
                placeholder: AppStrings.customerSearch,
                onChanged: controller.setSearch,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            AppCheckbox(
              label: AppStrings.filterShowArchived,
              value: controller.includeArchived,
              onChanged: controller.setIncludeArchived,
            ),
          ],
        ),
        content: StreamBuilder<List<Customer>>(
          stream: controller.customers,
          builder:
              (BuildContext context, AsyncSnapshot<List<Customer>> snapshot) {
                if (snapshot.hasError) {
                  return const AppErrorState();
                }
                final List<Customer>? customers = snapshot.data;
                if (customers == null) {
                  return const AppLoadingState();
                }
                if (customers.isEmpty) {
                  return controller.hasFilter
                      ? const AppEmptyState(
                          title: AppStrings.navCustomers,
                          description: AppStrings.emptySearch,
                          icon: AppIcons.search,
                        )
                      : AppEmptyState(
                          title: AppStrings.navCustomers,
                          description: AppStrings.emptyCustomers,
                          icon: AppIcons.customers,
                          actionLabel: AppStrings.customerCreate,
                          onAction: () => _edit(context),
                        );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      '${customers.length} ${AppStrings.customersCount}',
                      style: AppText.caption,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Expanded(child: _buildTable(context, customers)),
                  ],
                );
              },
        ),
      ),
    );
  }

  Widget _buildTable(BuildContext context, List<Customer> customers) {
    return AppDataTable<Customer>(
      rows: customers,
      onRowTap: (Customer customer) => _open(context, customer),
      actionsWidth: 176,
      columns: <AppDataColumn<Customer>>[
        AppDataColumn<Customer>(
          label: AppStrings.fieldName,
          flex: 2,
          cellBuilder: (Customer c) => AppTableText(
            c.isArchived
                ? '${c.fullName} (${AppStrings.archived})'
                : c.fullName,
          ),
          sortValue: (Customer c) =>
              '${c.lastName} ${c.firstName}'.toLowerCase(),
        ),
        AppDataColumn<Customer>(
          label: AppStrings.fieldEmail,
          flex: 2,
          cellBuilder: (Customer c) => AppTableText(c.email, isMuted: true),
          sortValue: (Customer c) => c.email.toLowerCase(),
        ),
        AppDataColumn<Customer>(
          label: AppStrings.fieldPhone,
          cellBuilder: (Customer c) => AppTableText(c.phone, isMuted: true),
        ),
        AppDataColumn<Customer>(
          label: AppStrings.fieldCity,
          cellBuilder: (Customer c) => AppTableText(c.city),
          sortValue: (Customer c) => c.city.toLowerCase(),
        ),
      ],
      actionsBuilder: (Customer customer) => <Widget>[
        if (!customer.isArchived)
          AppIconButton(
            icon: AppIcons.rent,
            tooltip: AppStrings.contractCreate,
            onPressed: () => _createContract(context, customer),
          ),
        AppIconButton(
          icon: AppIcons.edit,
          tooltip: AppStrings.actionEdit,
          onPressed: () => _edit(context, customer: customer),
        ),
        if (customer.isArchived)
          AppIconButton(
            icon: AppIcons.restore,
            tooltip: AppStrings.actionRestore,
            onPressed: () => _restore(context, customer),
          )
        else
          AppIconButton(
            icon: AppIcons.delete,
            tooltip: AppStrings.actionDelete,
            isDestructive: true,
            onPressed: () => _archive(context, customer),
          ),
        AppIconButton(
          icon: AppIcons.open,
          tooltip: AppStrings.actionOpen,
          onPressed: () => _open(context, customer),
        ),
      ],
    );
  }

  Future<void> _edit(BuildContext context, {Customer? customer}) async {
    final Object? saved = await showScopedDialog<Object>(
      context,
      (BuildContext context) => CustomerFormDialog(customer: customer),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
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

  Future<void> _archive(BuildContext context, Customer customer) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool confirmed = await AppDialog.confirmDelete(
      context,
      message: AppStrings.customerDeleteConfirm,
    );
    if (!confirmed || !context.mounted) {
      return;
    }
    await runAction(
      context,
      () => dependencies.customers.archive(customer.id),
      successMessage: AppStrings.deletedArchived,
    );
  }

  Future<void> _restore(BuildContext context, Customer customer) async {
    final AppDependencies dependencies = AppScope.of(context);
    await runAction(
      context,
      () => dependencies.customers.restore(customer.id),
      successMessage: AppStrings.restored,
    );
  }

  void _open(BuildContext context, Customer customer) {
    pushScopedPage<void>(
      context,
      (BuildContext context) => CustomerDetailPage(customerId: customer.id),
    );
  }
}

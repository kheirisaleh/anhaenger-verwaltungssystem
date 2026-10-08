import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_form.dart';
import '../../../core/design/widgets/app_text_field.dart';
import '../../../core/validation/validators.dart';
import '../../../data/models/customer.dart';
import '../../../data/repositories/repository_exception.dart';
import '../../../shared/app_dependencies.dart';

class CustomerFormDialog extends StatefulWidget {
  const CustomerFormDialog({super.key, this.customer});

  final Customer? customer;

  @override
  State<CustomerFormDialog> createState() => _CustomerFormDialogState();
}

class _CustomerFormDialogState extends State<CustomerFormDialog> {
  late final TextEditingController _firstName = _field(
    widget.customer?.firstName,
  );
  late final TextEditingController _lastName = _field(
    widget.customer?.lastName,
  );
  late final TextEditingController _email = _field(widget.customer?.email);
  late final TextEditingController _phone = _field(widget.customer?.phone);
  late final TextEditingController _street = _field(widget.customer?.street);
  late final TextEditingController _postalCode = _field(
    widget.customer?.postalCode,
  );
  late final TextEditingController _city = _field(widget.customer?.city);
  late final TextEditingController _license = _field(
    widget.customer?.licenseNumber,
  );
  final Map<String, String?> _errors = <String, String?>{};
  String? _error;
  bool _isSaving = false;

  TextEditingController _field(String? value) {
    return TextEditingController(text: value ?? '');
  }

  @override
  void dispose() {
    for (final TextEditingController controller in <TextEditingController>[
      _firstName,
      _lastName,
      _email,
      _phone,
      _street,
      _postalCode,
      _city,
      _license,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: widget.customer == null
          ? AppStrings.customerCreate
          : AppStrings.customerEdit,
      confirmLabel: AppStrings.actionSave,
      isLarge: true,
      isLoading: _isSaving,
      onConfirm: _save,
      content: AppForm(
        errorMessage: _error,
        children: <Widget>[
          AppFormRow(
            children: <Widget>[
              AppTextField(
                label: AppStrings.fieldFirstName,
                controller: _firstName,
                isRequired: true,
                errorText: _errors['firstName'],
              ),
              AppTextField(
                label: AppStrings.fieldLastName,
                controller: _lastName,
                isRequired: true,
                errorText: _errors['lastName'],
              ),
            ],
          ),
          AppFormRow(
            children: <Widget>[
              AppTextField(
                label: AppStrings.fieldEmail,
                controller: _email,
                isRequired: true,
                errorText: _errors['email'],
              ),
              AppTextField(
                label: AppStrings.fieldPhone,
                controller: _phone,
                isRequired: true,
                errorText: _errors['phone'],
              ),
            ],
          ),
          AppTextField(
            label: AppStrings.fieldStreet,
            controller: _street,
            isRequired: true,
            errorText: _errors['street'],
          ),
          AppFormRow(
            children: <Widget>[
              AppTextField(
                label: AppStrings.fieldPostalCode,
                controller: _postalCode,
                isRequired: true,
                errorText: _errors['postalCode'],
              ),
              AppTextField(
                label: AppStrings.fieldCity,
                controller: _city,
                isRequired: true,
                errorText: _errors['city'],
              ),
            ],
          ),
          AppTextField(
            label: AppStrings.fieldLicenseNumber,
            controller: _license,
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final Map<String, String?> errors = <String, String?>{
      'firstName': Validators.required(_firstName.text),
      'lastName': Validators.required(_lastName.text),
      'email': Validators.email(_email.text),
      'phone': Validators.required(_phone.text),
      'street': Validators.required(_street.text),
      'postalCode': Validators.required(_postalCode.text),
      'city': Validators.required(_city.text),
    };
    setState(() {
      _errors
        ..clear()
        ..addAll(errors);
      _error = null;
    });
    if (errors.values.any((String? message) => message != null)) {
      return;
    }
    final CustomerDraft draft = CustomerDraft(
      firstName: _firstName.text,
      lastName: _lastName.text,
      email: _email.text,
      phone: _phone.text,
      street: _street.text,
      postalCode: _postalCode.text,
      city: _city.text,
      licenseNumber: _license.text,
    );
    final AppDependencies dependencies = AppScope.of(context);
    setState(() => _isSaving = true);
    try {
      final Customer? existing = widget.customer;
      if (existing == null) {
        await dependencies.customers.create(draft);
      } else {
        await dependencies.customers.update(existing.id, draft);
      }
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } on RepositoryException catch (error) {
      if (mounted) {
        setState(() {
          _error = error.message;
          _isSaving = false;
        });
      }
    }
  }
}

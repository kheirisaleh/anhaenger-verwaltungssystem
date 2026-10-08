import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/widgets/app_date_time_field.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_form.dart';
import '../../../core/design/widgets/app_select_field.dart';
import '../../../core/design/widgets/app_text_field.dart';
import '../../../core/validation/validators.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/rental_contract.dart';
import '../../../data/models/trailer.dart';
import '../../../data/repositories/repository_exception.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/lookup_builder.dart';

class ContractFormDialog extends StatefulWidget {
  const ContractFormDialog({
    super.key,
    this.contract,
    this.customerId,
    this.trailerId,
  });

  final RentalContract? contract;
  final int? customerId;
  final int? trailerId;

  @override
  State<ContractFormDialog> createState() => _ContractFormDialogState();
}

class _ContractFormDialogState extends State<ContractFormDialog> {
  late int? _customerId = widget.contract?.customerId ?? widget.customerId;
  late int? _trailerId = widget.contract?.trailerId ?? widget.trailerId;
  late DateTime _startAt = widget.contract?.startAt ?? _defaultStart();
  late DateTime _endAt =
      widget.contract?.endAt ?? _defaultStart().add(const Duration(days: 1));
  late final TextEditingController _pickup = TextEditingController(
    text: widget.contract?.pickupLocation ?? AppStrings.defaultLocation,
  );
  late final TextEditingController _return = TextEditingController(
    text: widget.contract?.returnLocation ?? AppStrings.defaultLocation,
  );
  late final TextEditingController _price = TextEditingController(
    text: widget.contract == null
        ? ''
        : Validators.centsToInput(widget.contract!.priceCents),
  );
  String? _customerError;
  String? _trailerError;
  String? _dateError;
  String? _pickupError;
  String? _returnError;
  String? _priceError;
  String? _error;
  bool _isSaving = false;

  static DateTime _defaultStart() {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day + 1, 9);
  }

  @override
  void dispose() {
    _pickup.dispose();
    _return.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: widget.contract == null
          ? AppStrings.contractCreate
          : AppStrings.contractEdit,
      confirmLabel: AppStrings.actionSave,
      isLarge: true,
      isLoading: _isSaving,
      onConfirm: _save,
      content: LookupBuilder(
        builder: (BuildContext context, Lookups lookups) {
          final List<Customer> customers =
              lookups.customers.values
                  .where((Customer c) => !c.isArchived || c.id == _customerId)
                  .toList()
                ..sort(
                  (Customer a, Customer b) => a.lastName.compareTo(b.lastName),
                );
          final List<Trailer> trailers =
              lookups.trailers.values
                  .where((Trailer t) => !t.isArchived || t.id == _trailerId)
                  .toList()
                ..sort(
                  (Trailer a, Trailer b) =>
                      a.internalCode.compareTo(b.internalCode),
                );
          return AppForm(
            errorMessage: _error,
            children: <Widget>[
              AppFormRow(
                children: <Widget>[
                  AppSelectField<int>(
                    label: AppStrings.fieldCustomer,
                    isRequired: true,
                    value: customers.any((Customer c) => c.id == _customerId)
                        ? _customerId
                        : null,
                    placeholder: AppStrings.selectPlaceholder,
                    errorText: _customerError,
                    options: <AppSelectOption<int>>[
                      for (final Customer customer in customers)
                        AppSelectOption<int>(
                          value: customer.id,
                          label: customer.fullName,
                        ),
                    ],
                    onChanged: (int? id) => setState(() => _customerId = id),
                  ),
                  AppSelectField<int>(
                    label: AppStrings.fieldTrailer,
                    isRequired: true,
                    value: trailers.any((Trailer t) => t.id == _trailerId)
                        ? _trailerId
                        : null,
                    placeholder: AppStrings.selectPlaceholder,
                    errorText: _trailerError,
                    options: <AppSelectOption<int>>[
                      for (final Trailer trailer in trailers)
                        AppSelectOption<int>(
                          value: trailer.id,
                          label:
                              '${lookups.trailerName(trailer.id)} · '
                              '${trailer.type.name}',
                        ),
                    ],
                    onChanged: (int? id) => setState(() => _trailerId = id),
                  ),
                ],
              ),
              AppDateTimeField(
                label: AppStrings.fieldStartAt,
                isRequired: true,
                value: _startAt,
                onChanged: (DateTime value) => setState(() {
                  final Duration length = _endAt.difference(_startAt);
                  _startAt = value;
                  if (!_endAt.isAfter(_startAt)) {
                    _endAt = _startAt.add(
                      length.isNegative || length == Duration.zero
                          ? const Duration(days: 1)
                          : length,
                    );
                  }
                }),
              ),
              AppDateTimeField(
                label: AppStrings.fieldEndAt,
                isRequired: true,
                value: _endAt,
                errorText: _dateError,
                onChanged: (DateTime value) => setState(() => _endAt = value),
              ),
              AppFormRow(
                children: <Widget>[
                  AppTextField(
                    label: AppStrings.fieldPickupLocation,
                    controller: _pickup,
                    isRequired: true,
                    errorText: _pickupError,
                  ),
                  AppTextField(
                    label: AppStrings.fieldReturnLocation,
                    controller: _return,
                    isRequired: true,
                    errorText: _returnError,
                  ),
                ],
              ),
              AppTextField(
                label: AppStrings.fieldPriceEuro,
                controller: _price,
                isRequired: true,
                placeholder: AppStrings.placeholderMoney,
                errorText: _priceError,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _save() async {
    final int? customerId = _customerId;
    final int? trailerId = _trailerId;
    setState(() {
      _customerError = customerId == null
          ? AppStrings.validationRequired
          : null;
      _trailerError = trailerId == null ? AppStrings.validationRequired : null;
      _dateError = _endAt.isAfter(_startAt)
          ? null
          : AppStrings.validationDateRange;
      _pickupError = Validators.required(_pickup.text);
      _returnError = Validators.required(_return.text);
      _priceError = Validators.money(_price.text);
      _error = null;
    });
    final int? priceCents = Validators.parseCents(_price.text);
    if (_customerError != null ||
        _trailerError != null ||
        _dateError != null ||
        _pickupError != null ||
        _returnError != null ||
        _priceError != null ||
        customerId == null ||
        trailerId == null ||
        priceCents == null) {
      return;
    }
    final RentalContractDraft draft = RentalContractDraft(
      customerId: customerId,
      trailerId: trailerId,
      startAt: _startAt,
      endAt: _endAt,
      pickupLocation: _pickup.text,
      returnLocation: _return.text,
      priceCents: priceCents,
    );
    final AppDependencies dependencies = AppScope.of(context);
    setState(() => _isSaving = true);
    try {
      final RentalContract? existing = widget.contract;
      if (existing == null) {
        await dependencies.contracts.create(
          draft,
          userId: dependencies.currentUserId,
        );
      } else {
        await dependencies.contracts.update(existing.id, draft);
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

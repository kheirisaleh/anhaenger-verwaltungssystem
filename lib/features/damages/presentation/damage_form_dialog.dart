import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/design/widgets/app_date_time_field.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_form.dart';
import '../../../core/design/widgets/app_select_field.dart';
import '../../../core/design/widgets/app_text_field.dart';
import '../../../core/validation/validators.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/damage_record.dart';
import '../../../data/models/enums.dart';
import '../../../data/models/photo.dart';
import '../../../data/models/trailer.dart';
import '../../../data/repositories/repository_exception.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/lookup_builder.dart';
import '../../../shared/photo_gallery.dart';

class DamageFormDialog extends StatefulWidget {
  const DamageFormDialog({super.key, this.damage, this.trailerId});

  final DamageRecord? damage;
  final int? trailerId;

  @override
  State<DamageFormDialog> createState() => _DamageFormDialogState();
}

class _DamageFormDialogState extends State<DamageFormDialog> {
  late final TextEditingController _description = TextEditingController(
    text: widget.damage?.description ?? '',
  );
  late final TextEditingController _cost = TextEditingController(
    text: _initialCost(),
  );
  late int? _trailerId = widget.damage?.trailerId ?? widget.trailerId;
  late DateTime _eventDate = widget.damage?.eventDate ?? DateTime.now();
  late DamageType _damageType = widget.damage?.damageType ?? DamageType.other;
  late DamageCause _causedBy = widget.damage?.causedBy ?? DamageCause.unknown;
  late int? _customerId = widget.damage?.customerId;
  String? _trailerError;
  String? _descriptionError;
  String? _costError;
  String? _customerError;
  String? _error;
  bool _isSaving = false;

  String _initialCost() {
    final int? cents = widget.damage?.costCents;
    return cents == null ? '' : Validators.centsToInput(cents);
  }

  @override
  void dispose() {
    _description.dispose();
    _cost.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DamageRecord? existing = widget.damage;
    return AppDialog(
      title: existing == null ? AppStrings.damageCreate : AppStrings.damageEdit,
      confirmLabel: AppStrings.actionSave,
      isLarge: true,
      isLoading: _isSaving,
      onConfirm: _save,
      content: LookupBuilder(
        builder: (BuildContext context, Lookups lookups) {
          final List<Trailer> trailers =
              lookups.trailers.values
                  .where(
                    (Trailer t) => !t.isArchived || t.id == _trailerId,
                  )
                  .toList()
                ..sort(
                  (Trailer a, Trailer b) =>
                      a.internalCode.compareTo(b.internalCode),
                );
          final List<Customer> customers =
              lookups.customers.values
                  .where(
                    (Customer c) => !c.isArchived || c.id == _customerId,
                  )
                  .toList()
                ..sort(
                  (Customer a, Customer b) =>
                      a.lastName.compareTo(b.lastName),
                );
          return AppForm(
            errorMessage: _error,
            children: <Widget>[
              if (widget.trailerId == null)
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
                        label: lookups.trailerName(trailer.id),
                      ),
                  ],
                  onChanged: (int? id) => setState(() => _trailerId = id),
                ),
              AppFormRow(
                children: <Widget>[
                  AppDateTimeField(
                    label: AppStrings.fieldDate,
                    isRequired: true,
                    showTime: false,
                    value: _eventDate,
                    onChanged: (DateTime date) =>
                        setState(() => _eventDate = date),
                  ),
                  AppTextField(
                    label: AppStrings.fieldCostEuro,
                    controller: _cost,
                    placeholder: AppStrings.placeholderMoney,
                    errorText: _costError,
                  ),
                ],
              ),
              AppFormRow(
                children: <Widget>[
                  AppSelectField<DamageType>(
                    label: AppStrings.fieldDamageType,
                    isRequired: true,
                    value: _damageType,
                    options: <AppSelectOption<DamageType>>[
                      for (final DamageType type in DamageType.values)
                        AppSelectOption<DamageType>(
                          value: type,
                          label: type.label,
                        ),
                    ],
                    onChanged: (DamageType? type) {
                      if (type != null) {
                        setState(() => _damageType = type);
                      }
                    },
                  ),
                  AppSelectField<DamageCause>(
                    label: AppStrings.fieldCausedBy,
                    isRequired: true,
                    value: _causedBy,
                    options: <AppSelectOption<DamageCause>>[
                      for (final DamageCause cause in DamageCause.values)
                        AppSelectOption<DamageCause>(
                          value: cause,
                          label: cause.label,
                        ),
                    ],
                    onChanged: (DamageCause? cause) {
                      if (cause != null) {
                        setState(() => _causedBy = cause);
                      }
                    },
                  ),
                ],
              ),
              if (_causedBy == DamageCause.customer)
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
              AppTextField(
                label: AppStrings.fieldDescription,
                controller: _description,
                isRequired: true,
                maxLines: 3,
                errorText: _descriptionError,
              ),
              if (existing == null)
                const Text(
                  AppStrings.damagePhotosAfterSave,
                  style: AppText.bodyMuted,
                )
              else ...<Widget>[
                const Text(AppStrings.sectionPhotos, style: AppText.label),
                PhotoGallery(owner: DamagePhotoOwner(existing.id)),
              ],
            ],
          );
        },
      ),
    );
  }

  Future<void> _save() async {
    final int? trailerId = _trailerId;
    final int? customerId = _customerId;
    final bool needsCustomer = _causedBy == DamageCause.customer;
    setState(() {
      _trailerError = trailerId == null ? AppStrings.validationRequired : null;
      _descriptionError = Validators.required(_description.text);
      _costError = Validators.money(_cost.text, isRequired: false);
      _customerError = needsCustomer && customerId == null
          ? AppStrings.validationRequired
          : null;
      _error = null;
    });
    if (_trailerError != null ||
        _descriptionError != null ||
        _costError != null ||
        _customerError != null ||
        trailerId == null) {
      return;
    }
    final String costText = _cost.text.trim();
    final DamageRecordDraft draft = DamageRecordDraft(
      trailerId: trailerId,
      eventDate: _eventDate,
      description: _description.text,
      damageType: _damageType,
      causedBy: _causedBy,
      customerId: needsCustomer ? customerId : null,
      costCents: costText.isEmpty ? null : Validators.parseCents(costText),
    );
    final AppDependencies dependencies = AppScope.of(context);
    setState(() => _isSaving = true);
    try {
      final DamageRecord? existing = widget.damage;
      if (existing == null) {
        await dependencies.damages.create(
          draft,
          userId: dependencies.currentUserId,
        );
      } else {
        await dependencies.damages.update(existing.id, draft);
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

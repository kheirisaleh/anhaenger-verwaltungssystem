import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_checkbox.dart';
import '../../../core/design/widgets/app_date_time_field.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_form.dart';
import '../../../core/design/widgets/app_select_field.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/design/widgets/app_text_field.dart';
import '../../../core/formatting/app_formats.dart';
import '../../../core/validation/validators.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/enums.dart';
import '../../../data/models/rental_contract.dart';
import '../../../data/models/trailer.dart';
import '../../../data/repositories/repository_exception.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/lookup_builder.dart';
import '../../../shared/scoped_navigation.dart';
import '../../customers/presentation/customer_form_dialog.dart';
import '../../trailers/presentation/trailer_dialogs.dart';

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
    text: _initialPrice(),
  );
  Stream<List<RentalContract>>? _contracts;
  bool _handOverNow = false;
  String? _customerError;
  String? _trailerError;
  String? _dateError;
  String? _pickupError;
  String? _returnError;
  String? _priceError;
  String? _error;
  bool _isSaving = false;

  static const List<Duration> _quickDurations = <Duration>[
    Duration(hours: 4),
    Duration(days: 1),
    Duration(days: 2),
    Duration(days: 7),
  ];

  static DateTime _defaultStart() {
    final DateTime now = DateTime.now();
    final DateTime nextHour = DateTime(now.year, now.month, now.day, now.hour + 1);
    return nextHour.hour < 7 || nextHour.hour > 18
        ? DateTime(now.year, now.month, now.day + 1, 9)
        : nextHour;
  }

  String _initialPrice() {
    final RentalContract? contract = widget.contract;
    return contract == null ? '' : Validators.centsToInput(contract.priceCents);
  }

  bool get _startsToday {
    final DateTime now = DateTime.now();
    return _startAt.year == now.year &&
        _startAt.month == now.month &&
        _startAt.day == now.day;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _contracts ??= AppScope.of(context).contracts.watchAll();
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
      content: StreamBuilder<List<RentalContract>>(
        stream: _contracts,
        builder:
            (
              BuildContext context,
              AsyncSnapshot<List<RentalContract>> snapshot,
            ) {
              final List<RentalContract>? contracts = snapshot.data;
              if (contracts == null) {
                return const SizedBox(height: 160, child: AppLoadingState());
              }
              return LookupBuilder(
                builder: (BuildContext context, Lookups lookups) =>
                    _buildForm(context, lookups, contracts),
              );
            },
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    Lookups lookups,
    List<RentalContract> contracts,
  ) {
    final List<Customer> customers =
        lookups.customers.values
            .where((Customer c) => !c.isArchived || c.id == _customerId)
            .toList()
          ..sort((Customer a, Customer b) => a.lastName.compareTo(b.lastName));
    final List<Trailer> trailers =
        lookups.trailers.values
            .where((Trailer t) => !t.isArchived || t.id == _trailerId)
            .toList()
          ..sort(
            (Trailer a, Trailer b) => a.internalCode.compareTo(b.internalCode),
          );
    final int? ownId = widget.contract?.id;
    bool isBooked(Trailer trailer) => contracts.any(
      (RentalContract c) =>
          c.id != ownId &&
          c.trailerId == trailer.id &&
          c.overlaps(_startAt, _endAt),
    );
    final Trailer? selectedTrailer = lookups.trailers[_trailerId];
    final bool canHandOverNow =
        widget.contract == null &&
        _startsToday &&
        selectedTrailer != null &&
        selectedTrailer.status == TrailerStatus.available;

    return AppForm(
      errorMessage: _error,
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
                label: '${customer.fullName} · ${customer.city}',
              ),
          ],
          onChanged: (int? id) => setState(() {
            _customerId = id;
            _customerError = null;
          }),
          action: AppButton(
            label: AppStrings.actionNew,
            icon: AppIcons.add,
            onPressed: _createCustomer,
          ),
        ),
        AppFormRow(
          children: <Widget>[
            AppDateTimeField(
              label: AppStrings.fieldStartAt,
              isRequired: true,
              value: _startAt,
              onChanged: _setStart,
            ),
            AppDateTimeField(
              label: AppStrings.fieldEndAt,
              isRequired: true,
              value: _endAt,
              errorText: _dateError,
              onChanged: (DateTime value) => setState(() {
                _endAt = value;
                _dateError = null;
              }),
            ),
          ],
        ),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            const Text(AppStrings.contractQuickDuration, style: AppText.caption),
            for (final Duration duration in _quickDurations)
              AppButton(
                label: _durationLabel(duration),
                variant: AppButtonVariant.subtle,
                onPressed: () => setState(() {
                  _endAt = _startAt.add(duration);
                  _dateError = null;
                }),
              ),
            Text(
              '${AppStrings.contractDuration}: ${_durationLabel(_endAt.difference(_startAt))}',
              style: AppText.bodyMuted,
            ),
          ],
        ),
        AppSelectField<int>(
          label: AppStrings.fieldTrailer,
          isRequired: true,
          value: trailers.any((Trailer t) => t.id == _trailerId)
              ? _trailerId
              : null,
          placeholder: AppStrings.selectPlaceholder,
          errorText: _trailerError,
          helperText: _trailerHint(selectedTrailer, isBooked),
          options: <AppSelectOption<int>>[
            for (final Trailer trailer in trailers)
              AppSelectOption<int>(
                value: trailer.id,
                enabled: !isBooked(trailer) || trailer.id == _trailerId,
                label: _trailerLabel(trailer, isBooked(trailer)),
              ),
          ],
          onChanged: (int? id) => setState(() {
            _trailerId = id;
            _trailerError = null;
          }),
          action: AppButton(
            label: AppStrings.actionNew,
            icon: AppIcons.add,
            onPressed: _createTrailer,
          ),
        ),
        AppFormRow(
          children: <Widget>[
            AppTextField(
              label: AppStrings.fieldPickupLocation,
              controller: _pickup,
              isRequired: true,
              errorText: _pickupError,
              onSubmitted: (_) => _save(),
            ),
            AppTextField(
              label: AppStrings.fieldReturnLocation,
              controller: _return,
              isRequired: true,
              errorText: _returnError,
              onSubmitted: (_) => _save(),
            ),
          ],
        ),
        AppTextField(
          label: AppStrings.fieldPrice,
          controller: _price,
          isRequired: true,
          placeholder: AppStrings.placeholderMoney,
          suffixText: AppStrings.currencyEuro,
          helperText: _pricePerDay(),
          errorText: _priceError,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) => _save(),
        ),
        if (canHandOverNow)
          AppCheckbox(
            label: AppStrings.contractHandOverNow,
            value: _handOverNow,
            onChanged: (bool value) => setState(() => _handOverNow = value),
          ),
      ],
    );
  }

  void _setStart(DateTime value) {
    setState(() {
      final Duration length = _endAt.difference(_startAt);
      _startAt = value;
      _endAt = value.add(
        length.inMinutes <= 0 ? const Duration(days: 1) : length,
      );
      _dateError = null;
    });
  }

  String _durationLabel(Duration duration) {
    if (duration.inMinutes <= 0) {
      return AppStrings.none;
    }
    final int days = duration.inDays;
    final int hours = duration.inHours - days * 24;
    final List<String> parts = <String>[
      if (days > 0) '$days ${days == 1 ? AppStrings.day : AppStrings.days}',
      if (hours > 0) '$hours ${AppStrings.hoursShort}',
    ];
    return parts.isEmpty ? '< 1 ${AppStrings.hoursShort}' : parts.join(' ');
  }

  String _trailerLabel(Trailer trailer, bool booked) {
    final String base =
        '${trailer.internalCode} · ${trailer.licensePlate} · ${trailer.type.name}';
    if (booked) {
      return '$base · ${AppStrings.trailerBooked}';
    }
    if (trailer.status == TrailerStatus.maintenance ||
        trailer.status == TrailerStatus.blocked) {
      return '$base · ${trailer.status.label}';
    }
    return base;
  }

  String? _trailerHint(Trailer? trailer, bool Function(Trailer) isBooked) {
    if (trailer == null) {
      return AppStrings.contractTrailerHint;
    }
    if (isBooked(trailer)) {
      return AppStrings.errorContractOverlap;
    }
    if (trailer.status == TrailerStatus.maintenance ||
        trailer.status == TrailerStatus.blocked) {
      return '${AppStrings.contractTrailerNotReady} (${trailer.status.label})';
    }
    return null;
  }

  String? _pricePerDay() {
    final int? cents = Validators.parseCents(_price.text);
    final double days = _endAt.difference(_startAt).inMinutes / 1440;
    if (cents == null || days <= 0) {
      return null;
    }
    final int perDay = (cents / (days < 1 ? 1 : days)).round();
    return '${AppFormats.currencyFromCents(perDay)} ${AppStrings.perDay}';
  }

  Future<void> _createCustomer() async {
    final Object? created = await showScopedDialog<Object>(
      context,
      (BuildContext context) => const CustomerFormDialog(),
    );
    if (created is Customer && mounted) {
      setState(() {
        _customerId = created.id;
        _customerError = null;
      });
    }
  }

  Future<void> _createTrailer() async {
    final Object? created = await showScopedDialog<Object>(
      context,
      (BuildContext context) => const TrailerFormDialog(),
    );
    if (created is Trailer && mounted) {
      setState(() {
        _trailerId = created.id;
        _trailerError = null;
      });
    }
  }

  Future<void> _save() async {
    if (_isSaving) {
      return;
    }
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
      final RentalContract? result;
      if (existing == null) {
        result = await dependencies.contracts.create(
          draft,
          userId: dependencies.currentUserId,
        );
        if (_handOverNow && _startsToday) {
          await dependencies.contracts.handOver(
            result.id,
            userId: dependencies.currentUserId,
          );
        }
      } else {
        await dependencies.contracts.update(existing.id, draft);
        result = await dependencies.contracts.watchById(existing.id).first;
      }
      if (mounted) {
        Navigator.of(context).pop(result ?? true);
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

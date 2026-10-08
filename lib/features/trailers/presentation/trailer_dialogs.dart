import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_form.dart';
import '../../../core/design/widgets/app_select_field.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/design/widgets/app_text_field.dart';
import '../../../core/validation/validators.dart';
import '../../../data/models/enums.dart';
import '../../../data/models/trailer.dart';
import '../../../data/repositories/repository_exception.dart';
import '../../../shared/app_dependencies.dart';

class TrailerFormDialog extends StatefulWidget {
  const TrailerFormDialog({super.key, this.trailer});

  final Trailer? trailer;

  @override
  State<TrailerFormDialog> createState() => _TrailerFormDialogState();
}

class _TrailerFormDialogState extends State<TrailerFormDialog> {
  late final TextEditingController _code = TextEditingController(
    text: widget.trailer?.internalCode ?? '',
  );
  late final TextEditingController _plate = TextEditingController(
    text: widget.trailer?.licensePlate ?? '',
  );
  late int? _typeId = widget.trailer?.type.id;
  Future<List<TrailerType>>? _types;
  String? _codeError;
  String? _plateError;
  String? _typeError;
  String? _error;
  bool _isSaving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _types ??= AppScope.of(context).trailerTypes.watchAll().first;
  }

  @override
  void dispose() {
    _code.dispose();
    _plate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: widget.trailer == null
          ? AppStrings.trailerCreate
          : AppStrings.trailerEdit,
      confirmLabel: AppStrings.actionSave,
      isLoading: _isSaving,
      onConfirm: _save,
      content: FutureBuilder<List<TrailerType>>(
        future: _types,
        builder:
            (BuildContext context, AsyncSnapshot<List<TrailerType>> snapshot) {
              final List<TrailerType>? types = snapshot.data;
              if (types == null) {
                return const SizedBox(height: 120, child: AppLoadingState());
              }
              return AppForm(
                errorMessage: _error,
                children: <Widget>[
                  AppTextField(
                    label: AppStrings.fieldInternalCode,
                    controller: _code,
                    isRequired: true,
                    placeholder: AppStrings.placeholderInternalCode,
                    errorText: _codeError,
                  ),
                  AppTextField(
                    label: AppStrings.fieldLicensePlate,
                    controller: _plate,
                    isRequired: true,
                    placeholder: AppStrings.placeholderLicensePlate,
                    errorText: _plateError,
                  ),
                  AppSelectField<int>(
                    label: AppStrings.fieldTrailerType,
                    isRequired: true,
                    value: types.any((TrailerType t) => t.id == _typeId)
                        ? _typeId
                        : null,
                    placeholder: AppStrings.selectPlaceholder,
                    errorText: _typeError,
                    options: <AppSelectOption<int>>[
                      for (final TrailerType type in types)
                        AppSelectOption<int>(value: type.id, label: type.name),
                    ],
                    onChanged: (int? id) => setState(() => _typeId = id),
                  ),
                ],
              );
            },
      ),
    );
  }

  Future<void> _save() async {
    final int? typeId = _typeId;
    setState(() {
      _codeError = Validators.required(_code.text);
      _plateError = Validators.required(_plate.text);
      _typeError = typeId == null ? AppStrings.validationRequired : null;
      _error = null;
    });
    if (_codeError != null ||
        _plateError != null ||
        _typeError != null ||
        typeId == null) {
      return;
    }
    final AppDependencies dependencies = AppScope.of(context);
    final TrailerDraft draft = TrailerDraft(
      internalCode: _code.text,
      licensePlate: _plate.text,
      typeId: typeId,
    );
    setState(() => _isSaving = true);
    try {
      final Trailer? existing = widget.trailer;
      if (existing == null) {
        await dependencies.trailers.create(
          draft,
          userId: dependencies.currentUserId,
        );
      } else {
        await dependencies.trailers.update(existing.id, draft);
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

class TrailerStatusDialog extends StatefulWidget {
  const TrailerStatusDialog({super.key, required this.trailer});

  final Trailer trailer;

  @override
  State<TrailerStatusDialog> createState() => _TrailerStatusDialogState();
}

class _TrailerStatusDialogState extends State<TrailerStatusDialog> {
  late TrailerStatus _status = widget.trailer.status == TrailerStatus.rented
      ? TrailerStatus.available
      : widget.trailer.status;
  String? _error;
  bool _isSaving = false;

  bool get _isRented => widget.trailer.status == TrailerStatus.rented;

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: AppStrings.trailerChangeStatus,
      confirmLabel: _isRented ? AppStrings.actionClose : AppStrings.actionSave,
      isLoading: _isSaving,
      onConfirm: _isRented ? () => Navigator.of(context).pop(false) : _save,
      content: AppForm(
        errorMessage: _error,
        children: <Widget>[
          if (_isRented)
            const Text(
              AppStrings.errorStatusChangeNotAllowed,
              style: AppText.body,
            )
          else ...<Widget>[
            const Text(AppStrings.trailerStatusHint, style: AppText.bodyMuted),
            AppSelectField<TrailerStatus>(
              label: AppStrings.fieldStatus,
              isRequired: true,
              value: _status,
              options: <AppSelectOption<TrailerStatus>>[
                for (final TrailerStatus status in TrailerStatus.values)
                  if (status != TrailerStatus.rented)
                    AppSelectOption<TrailerStatus>(
                      value: status,
                      label: status.label,
                    ),
              ],
              onChanged: (TrailerStatus? status) {
                if (status != null) {
                  setState(() => _status = status);
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _save() async {
    final AppDependencies dependencies = AppScope.of(context);
    setState(() {
      _isSaving = true;
      _error = null;
    });
    try {
      await dependencies.trailers.changeStatus(
        widget.trailer.id,
        _status,
        userId: dependencies.currentUserId,
      );
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

class TrailerLocationDialog extends StatefulWidget {
  const TrailerLocationDialog({super.key, required this.trailer});

  final Trailer trailer;

  @override
  State<TrailerLocationDialog> createState() => _TrailerLocationDialogState();
}

class _TrailerLocationDialogState extends State<TrailerLocationDialog> {
  late final TextEditingController _address = TextEditingController(
    text: widget.trailer.location.address ?? '',
  );
  late final TextEditingController _latitude = TextEditingController(
    text: widget.trailer.location.latitude?.toString() ?? '',
  );
  late final TextEditingController _longitude = TextEditingController(
    text: widget.trailer.location.longitude?.toString() ?? '',
  );
  String? _latitudeError;
  String? _longitudeError;
  String? _error;
  bool _isSaving = false;

  @override
  void dispose() {
    _address.dispose();
    _latitude.dispose();
    _longitude.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: AppStrings.trailerChangeLocation,
      confirmLabel: AppStrings.actionSave,
      isLoading: _isSaving,
      onConfirm: _save,
      content: AppForm(
        errorMessage: _error,
        children: <Widget>[
          AppTextField(
            label: AppStrings.fieldAddress,
            controller: _address,
            placeholder: AppStrings.placeholderAddress,
          ),
          AppFormRow(
            children: <Widget>[
              AppTextField(
                label: AppStrings.fieldLatitude,
                controller: _latitude,
                placeholder: AppStrings.placeholderLatitude,
                errorText: _latitudeError,
              ),
              AppTextField(
                label: AppStrings.fieldLongitude,
                controller: _longitude,
                placeholder: AppStrings.placeholderLongitude,
                errorText: _longitudeError,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    setState(() {
      _latitudeError = Validators.coordinate(_latitude.text, limit: 90);
      _longitudeError = Validators.coordinate(_longitude.text, limit: 180);
      _error = null;
    });
    if (_latitudeError != null || _longitudeError != null) {
      return;
    }
    final AppDependencies dependencies = AppScope.of(context);
    setState(() => _isSaving = true);
    try {
      await dependencies.trailers.updateLocation(
        widget.trailer.id,
        TrailerLocation(
          address: _address.text,
          latitude: Validators.parseDecimal(_latitude.text),
          longitude: Validators.parseDecimal(_longitude.text),
        ),
      );
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

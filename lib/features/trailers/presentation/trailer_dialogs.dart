import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_form.dart';
import '../../../core/design/widgets/app_select_field.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/design/widgets/app_text_field.dart';
import '../../../core/validation/validators.dart';
import '../../../data/models/trailer.dart';
import '../../../data/repositories/repository_exception.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/name_dialog.dart';
import '../../../shared/scoped_navigation.dart';

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
  Stream<List<TrailerType>>? _types;
  String? _codeError;
  String? _plateError;
  String? _typeError;
  String? _error;
  bool _isSaving = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _types ??= AppScope.of(context).trailerTypes.watchAll();
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
      content: StreamBuilder<List<TrailerType>>(
        stream: _types,
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
                    autofocus: true,
                    placeholder: AppStrings.placeholderInternalCode,
                    helperText: AppStrings.helperInternalCode,
                    errorText: _codeError,
                    onSubmitted: (_) => _save(),
                  ),
                  AppTextField(
                    label: AppStrings.fieldLicensePlate,
                    controller: _plate,
                    isRequired: true,
                    placeholder: AppStrings.placeholderLicensePlate,
                    errorText: _plateError,
                    onSubmitted: (_) => _save(),
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
                    action: AppButton(
                      label: AppStrings.actionNew,
                      icon: AppIcons.add,
                      onPressed: _createType,
                    ),
                  ),
                ],
              );
            },
      ),
    );
  }

  Future<void> _createType() async {
    final AppDependencies dependencies = AppScope.of(context);
    final Object? created = await showScopedDialog<Object>(
      context,
      (BuildContext context) => NameDialog(
        title: AppStrings.trailerTypeCreate,
        label: AppStrings.fieldName,
        onSave: (String name) => dependencies.trailerTypes.create(name),
      ),
    );
    if (created is TrailerType && mounted) {
      setState(() {
        _typeId = created.id;
        _typeError = null;
      });
    }
  }

  Future<void> _save() async {
    if (_isSaving) {
      return;
    }
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
      final Trailer? result;
      if (existing == null) {
        result = await dependencies.trailers.create(
          draft,
          userId: dependencies.currentUserId,
        );
      } else {
        await dependencies.trailers.update(existing.id, draft);
        result = await dependencies.trailers.watchById(existing.id).first;
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
            autofocus: true,
            onSubmitted: (_) => _save(),
            placeholder: AppStrings.placeholderAddress,
          ),
          AppFormRow(
            children: <Widget>[
              AppTextField(
                label: AppStrings.fieldLatitude,
                controller: _latitude,
                onSubmitted: (_) => _save(),
                placeholder: AppStrings.placeholderLatitude,
                errorText: _latitudeError,
              ),
              AppTextField(
                label: AppStrings.fieldLongitude,
                controller: _longitude,
                onSubmitted: (_) => _save(),
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

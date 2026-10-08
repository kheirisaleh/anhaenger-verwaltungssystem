import 'package:fluent_ui/fluent_ui.dart';

import '../core/constants/app_strings.dart';
import '../core/design/widgets/app_dialog.dart';
import '../core/design/widgets/app_form.dart';
import '../core/design/widgets/app_text_field.dart';
import '../core/validation/validators.dart';
import '../data/repositories/repository_exception.dart';

class NameDialog extends StatefulWidget {
  const NameDialog({
    super.key,
    required this.title,
    required this.label,
    required this.onSave,
    this.initialValue = '',
  });

  final String title;
  final String label;
  final String initialValue;
  final Future<Object?> Function(String name) onSave;

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  late final TextEditingController _name = TextEditingController(
    text: widget.initialValue,
  );
  String? _nameError;
  String? _error;
  bool _isSaving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: widget.title,
      confirmLabel: AppStrings.actionSave,
      isLoading: _isSaving,
      onConfirm: _save,
      content: AppForm(
        errorMessage: _error,
        children: <Widget>[
          AppTextField(
            label: widget.label,
            controller: _name,
            isRequired: true,
            autofocus: true,
            onSubmitted: (_) => _save(),
            errorText: _nameError,
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    setState(() {
      _nameError = Validators.required(_name.text);
      _error = null;
    });
    if (_nameError != null) {
      return;
    }
    setState(() => _isSaving = true);
    try {
      final Object? result = await widget.onSave(_name.text.trim());
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

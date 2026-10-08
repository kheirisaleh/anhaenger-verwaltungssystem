import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import '../core/constants/app_strings.dart';
import '../core/design/widgets/app_messages.dart';
import '../data/repositories/repository_exception.dart';

Future<bool> runAction(
  BuildContext context,
  Future<void> Function() action, {
  String? successMessage,
}) async {
  try {
    await action();
    if (context.mounted) {
      AppMessages.success(context, successMessage);
    }
    return true;
  } on RepositoryException catch (error) {
    if (context.mounted) {
      AppMessages.error(context, error.message);
    }
  } on FileSystemException {
    if (context.mounted) {
      AppMessages.error(context, AppStrings.errorFile);
    }
  }
  return false;
}

void showSavedIfTrue(BuildContext context, bool? saved) {
  if (saved == true && context.mounted) {
    AppMessages.success(context);
  }
}

import 'package:fluent_ui/fluent_ui.dart';

import '../../constants/app_strings.dart';

abstract final class AppMessages {
  static void success(BuildContext context, [String? message]) {
    _show(
      context,
      message ?? AppStrings.saveSuccess,
      InfoBarSeverity.success,
    );
  }

  static void error(BuildContext context, String message) {
    _show(context, message, InfoBarSeverity.error);
  }

  static void _show(
    BuildContext context,
    String message,
    InfoBarSeverity severity,
  ) {
    displayInfoBar(
      context,
      builder: (BuildContext context, VoidCallback close) => InfoBar(
        title: Text(message),
        severity: severity,
        onClose: close,
      ),
    );
  }
}

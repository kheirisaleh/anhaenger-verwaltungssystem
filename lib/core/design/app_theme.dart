import 'package:fluent_ui/fluent_ui.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static FluentThemeData build() {
    return FluentThemeData(
      brightness: Brightness.light,
      accentColor: AccentColor.swatch(const <String, Color>{
        'normal': AppColors.accent,
        'dark': AppColors.accentHover,
      }),
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.surface,
      fontFamily: 'Segoe UI',
    );
  }
}

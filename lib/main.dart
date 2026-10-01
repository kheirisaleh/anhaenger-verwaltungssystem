import 'package:fluent_ui/fluent_ui.dart';

import 'core/constants/app_strings.dart';
import 'core/design/app_theme.dart';
import 'shared/app_shell.dart';

void main() {
  runApp(const AnhaengerApp());
}

class AnhaengerApp extends StatelessWidget {
  const AnhaengerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      home: const AppShell(),
    );
  }
}

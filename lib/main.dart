import 'package:fluent_ui/fluent_ui.dart';

import 'core/constants/app_strings.dart';
import 'core/design/app_theme.dart';
import 'core/formatting/app_formats.dart';
import 'shared/app_root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppFormats.initialize();
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
      locale: const Locale('de'),
      home: const AppRoot(),
    );
  }
}

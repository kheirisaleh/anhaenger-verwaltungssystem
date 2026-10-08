import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import 'damage_table.dart';

class DamagesPage extends StatelessWidget {
  const DamagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPageScaffold(
      title: AppStrings.navDamages,
      content: DamageTable(),
    );
  }
}

import 'package:fluent_ui/fluent_ui.dart';

import '../core/constants/app_strings.dart';
import '../core/design/app_colors.dart';
import '../core/design/app_spacing.dart';
import '../core/design/app_typography.dart';
import '../core/design/widgets/app_button.dart';
import '../core/design/widgets/app_card.dart';
import '../core/design/widgets/app_select_field.dart';
import '../core/design/widgets/app_state_views.dart';
import '../data/models/app_user.dart';
import 'app_dependencies.dart';

class UserSelectionPage extends StatefulWidget {
  const UserSelectionPage({super.key});

  @override
  State<UserSelectionPage> createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  Stream<List<AppUser>>? _users;
  int? _selectedId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _users ??= AppScope.of(context).users.watchAll();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.formMaxWidth),
          child: StreamBuilder<List<AppUser>>(
            stream: _users,
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<List<AppUser>> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const AppErrorState(
                      message: AppStrings.startupError,
                    );
                  }
                  final List<AppUser>? users = snapshot.data;
                  if (users == null) {
                    return const AppLoadingState();
                  }
                  return _buildForm(users);
                },
          ),
        ),
      ),
    );
  }

  Widget _buildForm(List<AppUser> users) {
    final int? selectedId = users.any((AppUser user) => user.id == _selectedId)
        ? _selectedId
        : null;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(AppStrings.appTitle, style: AppText.pageTitle),
          const SizedBox(height: AppSpacing.lg),
          AppSelectField<int>(
            label: AppStrings.startupSelectUser,
            isRequired: true,
            value: selectedId,
            options: <AppSelectOption<int>>[
              for (final AppUser user in users)
                AppSelectOption<int>(value: user.id, label: user.name),
            ],
            onChanged: (int? id) => setState(() => _selectedId = id),
          ),
          const SizedBox(height: AppSpacing.lg),
          Align(
            alignment: Alignment.centerRight,
            child: AppButton(
              label: AppStrings.actionStart,
              variant: AppButtonVariant.primary,
              onPressed: selectedId == null
                  ? null
                  : () => _signIn(
                      users.firstWhere((AppUser user) => user.id == selectedId),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _signIn(AppUser user) {
    AppScope.of(context).currentUser.value = user;
  }
}

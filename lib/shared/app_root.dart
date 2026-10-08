import 'package:fluent_ui/fluent_ui.dart';

import '../core/constants/app_strings.dart';
import '../core/design/widgets/app_state_views.dart';
import '../data/models/app_user.dart';
import 'app_dependencies.dart';
import 'app_shell.dart';
import 'user_selection_page.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key, this.openDependencies = AppDependencies.open});

  final Future<AppDependencies> Function() openDependencies;

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late Future<AppDependencies> _dependencies = widget.openDependencies();

  @override
  void dispose() {
    _dependencies
        .then<void>((AppDependencies dependencies) => dependencies.dispose())
        .ignore();
    super.dispose();
  }

  void _retry() {
    setState(() => _dependencies = widget.openDependencies());
  }

  void _restart(Future<void> Function() whileClosed) {
    final Future<AppDependencies> previous = _dependencies;
    final Future<AppDependencies> next = _reopen(previous, whileClosed);
    setState(() => _dependencies = next);
  }

  Future<AppDependencies> _reopen(
    Future<AppDependencies> previous,
    Future<void> Function() whileClosed,
  ) async {
    await WidgetsBinding.instance.endOfFrame;
    final AppDependencies old = await previous;
    await old.dispose();
    await whileClosed();
    return widget.openDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDependencies>(
      future: _dependencies,
      builder: (BuildContext context, AsyncSnapshot<AppDependencies> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const AppLoadingState();
        }
        final AppDependencies? dependencies = snapshot.data;
        if (snapshot.hasError || dependencies == null) {
          return AppErrorState(
            message: AppStrings.startupError,
            onRetry: _retry,
          );
        }
        return AppScope(
          dependencies: dependencies,
          restart: _restart,
          child: ValueListenableBuilder<AppUser?>(
            valueListenable: dependencies.currentUser,
            builder: (BuildContext context, AppUser? user, Widget? child) {
              if (user == null) {
                return const UserSelectionPage();
              }
              return AppShell(
                user: user,
                onSwitchUser: () => dependencies.currentUser.value = null,
              );
            },
          ),
        );
      },
    );
  }
}

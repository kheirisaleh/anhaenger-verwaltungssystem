import 'package:fluent_ui/fluent_ui.dart';

import 'app_dependencies.dart';

Future<T?> showScopedDialog<T>(BuildContext context, WidgetBuilder builder) {
  final AppDependencies dependencies = AppScope.of(context);
  final AppRestart? restart = AppScope.restartOf(context);
  return showDialog<T>(
    context: context,
    builder: (BuildContext dialogContext) => AppScope(
      dependencies: dependencies,
      restart: restart,
      child: Builder(builder: builder),
    ),
  );
}

Future<T?> pushScopedPage<T>(BuildContext context, WidgetBuilder builder) {
  final AppDependencies dependencies = AppScope.of(context);
  final AppRestart? restart = AppScope.restartOf(context);
  return Navigator.of(context).push<T>(
    FluentPageRoute<T>(
      builder: (BuildContext pageContext) => AppScope(
        dependencies: dependencies,
        restart: restart,
        child: Builder(builder: builder),
      ),
    ),
  );
}

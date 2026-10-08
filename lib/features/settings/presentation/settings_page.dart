import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_card.dart';
import '../../../core/design/widgets/app_data_table.dart';
import '../../../core/design/widgets/app_dialog.dart';
import '../../../core/design/widgets/app_icon_button.dart';
import '../../../core/design/widgets/app_messages.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/trailer.dart';
import '../../../data/sources/backup_service.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/file_dialogs.dart';
import '../../../shared/run_action.dart';
import '../../../shared/scoped_navigation.dart';
import 'name_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Stream<List<AppUser>>? _users;
  Stream<List<TrailerType>>? _types;
  bool _isBusy = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppDependencies dependencies = AppScope.of(context);
    _users ??= dependencies.users.watchAll(includeInactive: true);
    _types ??= dependencies.trailerTypes.watchAll();
  }

  @override
  Widget build(BuildContext context) {
    return AppPageScaffold(
      title: AppStrings.navSettings,
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: _buildUsers(context)),
                const SizedBox(width: AppSpacing.lg),
                Expanded(child: _buildTypes(context)),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildBackup(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUsers(BuildContext context) {
    return AppCard(
      title: AppStrings.settingsUsers,
      child: StreamBuilder<List<AppUser>>(
        stream: _users,
        builder: (BuildContext context, AsyncSnapshot<List<AppUser>> snapshot) {
          final List<AppUser>? users = snapshot.data;
          if (users == null) {
            return const SizedBox(height: 120, child: AppLoadingState());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppDataTable<AppUser>(
                rows: users,
                shrinkWrap: true,
                actionsWidth: 96,
                columns: <AppDataColumn<AppUser>>[
                  AppDataColumn<AppUser>(
                    label: AppStrings.fieldName,
                    flex: 2,
                    cellBuilder: (AppUser u) => AppTableText(u.name),
                  ),
                  AppDataColumn<AppUser>(
                    label: AppStrings.fieldStatus,
                    cellBuilder: (AppUser u) => AppTableText(
                      u.isActive
                          ? AppStrings.userActive
                          : AppStrings.userInactive,
                      isMuted: !u.isActive,
                    ),
                  ),
                ],
                actionsBuilder: (AppUser user) => <Widget>[
                  AppIconButton(
                    icon: AppIcons.edit,
                    tooltip: AppStrings.actionRename,
                    onPressed: () => _renameUser(context, user),
                  ),
                  AppIconButton(
                    icon: user.isActive ? AppIcons.cancel : AppIcons.restore,
                    tooltip: user.isActive
                        ? AppStrings.userDeactivate
                        : AppStrings.userActivate,
                    isDestructive: user.isActive,
                    onPressed: () => _toggleUser(context, user),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: AppButton(
                  label: AppStrings.userCreate,
                  icon: AppIcons.add,
                  onPressed: () => _createUser(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTypes(BuildContext context) {
    return AppCard(
      title: AppStrings.settingsTrailerTypes,
      child: StreamBuilder<List<TrailerType>>(
        stream: _types,
        builder:
            (BuildContext context, AsyncSnapshot<List<TrailerType>> snapshot) {
              final List<TrailerType>? types = snapshot.data;
              if (types == null) {
                return const SizedBox(height: 120, child: AppLoadingState());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppDataTable<TrailerType>(
                    rows: types,
                    shrinkWrap: true,
                    actionsWidth: 96,
                    columns: <AppDataColumn<TrailerType>>[
                      AppDataColumn<TrailerType>(
                        label: AppStrings.fieldName,
                        cellBuilder: (TrailerType t) => AppTableText(t.name),
                      ),
                    ],
                    actionsBuilder: (TrailerType type) => <Widget>[
                      AppIconButton(
                        icon: AppIcons.edit,
                        tooltip: AppStrings.actionRename,
                        onPressed: () => _renameType(context, type),
                      ),
                      AppIconButton(
                        icon: AppIcons.delete,
                        tooltip: AppStrings.actionDelete,
                        isDestructive: true,
                        onPressed: () => _deleteType(context, type),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppButton(
                      label: AppStrings.trailerTypeCreate,
                      icon: AppIcons.add,
                      onPressed: () => _createType(context),
                    ),
                  ),
                ],
              );
            },
      ),
    );
  }

  Widget _buildBackup(BuildContext context) {
    return AppCard(
      title: AppStrings.settingsBackup,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(AppStrings.backupDescription, style: AppText.bodyMuted),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: <Widget>[
              AppButton(
                label: AppStrings.backupExport,
                icon: AppIcons.export,
                isLoading: _isBusy,
                onPressed: () => _exportBackup(context),
              ),
              AppButton(
                label: AppStrings.backupImport,
                icon: AppIcons.importData,
                onPressed: _isBusy ? null : () => _importBackup(context),
              ),
              AppButton(
                label: AppStrings.sampleDataLoad,
                icon: AppIcons.sampleData,
                onPressed: _isBusy ? null : () => _loadSampleData(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _createUser(BuildContext context) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool? saved = await showScopedDialog<bool>(
      context,
      (BuildContext context) => NameDialog(
        title: AppStrings.userCreate,
        label: AppStrings.fieldName,
        onSave: (String name) => dependencies.users.create(name),
      ),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
  }

  Future<void> _renameUser(BuildContext context, AppUser user) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool? saved = await showScopedDialog<bool>(
      context,
      (BuildContext context) => NameDialog(
        title: AppStrings.actionRename,
        label: AppStrings.fieldName,
        initialValue: user.name,
        onSave: (String name) => dependencies.users.rename(user.id, name),
      ),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
  }

  Future<void> _toggleUser(BuildContext context, AppUser user) async {
    final AppDependencies dependencies = AppScope.of(context);
    if (user.isActive && user.id == dependencies.currentUserId) {
      AppMessages.error(context, AppStrings.userDeactivateSelf);
      return;
    }
    await runAction(
      context,
      () => dependencies.users.setActive(user.id, isActive: !user.isActive),
    );
  }

  Future<void> _createType(BuildContext context) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool? saved = await showScopedDialog<bool>(
      context,
      (BuildContext context) => NameDialog(
        title: AppStrings.trailerTypeCreate,
        label: AppStrings.fieldName,
        onSave: (String name) => dependencies.trailerTypes.create(name),
      ),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
  }

  Future<void> _renameType(BuildContext context, TrailerType type) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool? saved = await showScopedDialog<bool>(
      context,
      (BuildContext context) => NameDialog(
        title: AppStrings.actionRename,
        label: AppStrings.fieldName,
        initialValue: type.name,
        onSave: (String name) =>
            dependencies.trailerTypes.rename(type.id, name),
      ),
    );
    if (context.mounted) {
      showSavedIfTrue(context, saved);
    }
  }

  Future<void> _deleteType(BuildContext context, TrailerType type) async {
    final AppDependencies dependencies = AppScope.of(context);
    final bool confirmed = await AppDialog.confirmDelete(context);
    if (!confirmed || !context.mounted) {
      return;
    }
    await runAction(
      context,
      () => dependencies.trailerTypes.delete(type.id),
      successMessage: AppStrings.deleted,
    );
  }

  Future<void> _exportBackup(BuildContext context) async {
    final AppDependencies dependencies = AppScope.of(context);
    final Directory? parent = await FileDialogs.pickDirectory();
    if (parent == null || !context.mounted) {
      return;
    }
    setState(() => _isBusy = true);
    try {
      final Directory target = await dependencies.backup.export(parent);
      if (context.mounted) {
        AppMessages.success(
          context,
          '${AppStrings.backupExportDone} ${target.path}',
        );
      }
    } on Object {
      if (context.mounted) {
        AppMessages.error(context, AppStrings.backupExportFailed);
      }
    } finally {
      if (mounted) {
        setState(() => _isBusy = false);
      }
    }
  }

  Future<void> _importBackup(BuildContext context) async {
    final AppDependencies dependencies = AppScope.of(context);
    final AppRestart? restart = AppScope.restartOf(context);
    final Directory? source = await FileDialogs.pickDirectory();
    if (source == null || !context.mounted) {
      return;
    }
    if (!BackupService.isBackupFolder(source)) {
      AppMessages.error(context, AppStrings.backupInvalidFolder);
      return;
    }
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const AppDialog(
        title: AppStrings.backupImport,
        content: Text(AppStrings.backupImportConfirm, style: AppText.body),
        confirmLabel: AppStrings.backupImport,
        isDestructive: true,
      ),
    );
    if (confirmed != true || restart == null) {
      return;
    }
    restart(
      () => BackupService.restoreFiles(source, dependencies.directories),
    );
  }

  Future<void> _loadSampleData(BuildContext context) async {
    final AppDependencies dependencies = AppScope.of(context);
    setState(() => _isBusy = true);
    try {
      final bool seeded = await dependencies.sampleData().seedIfEmpty();
      if (context.mounted) {
        if (seeded) {
          AppMessages.success(context, AppStrings.sampleDataLoaded);
        } else {
          AppMessages.error(context, AppStrings.sampleDataNotEmpty);
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isBusy = false);
      }
    }
  }
}

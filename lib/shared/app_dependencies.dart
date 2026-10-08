import 'package:fluent_ui/fluent_ui.dart';

import '../core/database/app_database.dart';
import '../core/database/app_directories.dart';
import '../data/models/app_user.dart';
import '../data/repositories/contract_repository.dart';
import '../data/repositories/customer_repository.dart';
import '../data/repositories/damage_repository.dart';
import '../data/repositories/drift/drift_contract_repository.dart';
import '../data/repositories/drift/drift_customer_repository.dart';
import '../data/repositories/drift/drift_damage_repository.dart';
import '../data/repositories/drift/drift_photo_repository.dart';
import '../data/repositories/drift/drift_trailer_repository.dart';
import '../data/repositories/drift/drift_trailer_type_repository.dart';
import '../data/repositories/drift/drift_user_repository.dart';
import '../data/repositories/photo_repository.dart';
import '../data/repositories/trailer_repository.dart';
import '../data/repositories/trailer_type_repository.dart';
import '../data/repositories/user_repository.dart';
import '../data/sources/backup_service.dart';
import '../data/sources/photo_file_store.dart';
import '../data/sources/sample_data_seeder.dart';

typedef AppRestart = void Function(Future<void> Function() whileClosed);

class AppDependencies {
  AppDependencies({
    required this.database,
    required this.directories,
    required this.users,
    required this.trailerTypes,
    required this.trailers,
    required this.customers,
    required this.contracts,
    required this.damages,
    required this.photos,
    required this.backup,
  });

  factory AppDependencies.create(
    AppDatabase database,
    AppDirectories directories,
  ) {
    final PhotoFileStore files = PhotoFileStore(directories);
    return AppDependencies(
      database: database,
      directories: directories,
      users: DriftUserRepository(database),
      trailerTypes: DriftTrailerTypeRepository(database),
      trailers: DriftTrailerRepository(database),
      customers: DriftCustomerRepository(database),
      contracts: DriftContractRepository(database),
      damages: DriftDamageRepository(database, files),
      photos: DriftPhotoRepository(database, files),
      backup: BackupService(database, directories),
    );
  }

  static Future<AppDependencies> open() async {
    final AppDirectories directories = await AppDirectories.resolve();
    final AppDatabase database = AppDatabase.open(directories);
    final AppDependencies dependencies = AppDependencies.create(
      database,
      directories,
    );
    try {
      await dependencies.sampleData().seedIfEmpty();
    } on Object catch (error) {
      debugPrint('Beispieldaten konnten nicht geladen werden: $error');
    }
    return dependencies;
  }

  final AppDatabase database;
  final AppDirectories directories;
  final UserRepository users;
  final TrailerTypeRepository trailerTypes;
  final TrailerRepository trailers;
  final CustomerRepository customers;
  final ContractRepository contracts;
  final DamageRepository damages;
  final PhotoRepository photos;
  final BackupService backup;

  final ValueNotifier<AppUser?> currentUser = ValueNotifier<AppUser?>(null);

  int get currentUserId => currentUser.value?.id ?? 1;

  SampleDataSeeder sampleData() {
    return SampleDataSeeder(
      users: users,
      trailerTypes: trailerTypes,
      trailers: trailers,
      customers: customers,
      contracts: contracts,
      damages: damages,
    );
  }

  Future<void> dispose() async {
    currentUser.dispose();
    await database.close();
  }
}

class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.dependencies,
    required super.child,
    this.restart,
  });

  final AppDependencies dependencies;
  final AppRestart? restart;

  static AppDependencies of(BuildContext context) {
    return _scope(context).dependencies;
  }

  static AppRestart? restartOf(BuildContext context) {
    return _scope(context).restart;
  }

  static AppScope _scope(BuildContext context) {
    final AppScope? scope = context
        .dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope fehlt im Widget-Baum.');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      dependencies != oldWidget.dependencies || restart != oldWidget.restart;
}

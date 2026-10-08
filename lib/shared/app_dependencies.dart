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
import '../data/sources/photo_file_store.dart';

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
    );
  }

  static Future<AppDependencies> open() async {
    final AppDirectories directories = await AppDirectories.resolve();
    final AppDatabase database = AppDatabase.open(directories);
    return AppDependencies.create(database, directories);
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

  final ValueNotifier<AppUser?> currentUser = ValueNotifier<AppUser?>(null);

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
  });

  final AppDependencies dependencies;

  static AppDependencies of(BuildContext context) {
    final AppScope? scope = context
        .dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope fehlt im Widget-Baum.');
    return scope!.dependencies;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      dependencies != oldWidget.dependencies;
}

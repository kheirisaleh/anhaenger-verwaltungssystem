import '../models/app_user.dart';

abstract interface class UserRepository {
  Stream<List<AppUser>> watchAll({bool includeInactive = false});

  Future<AppUser> create(String name);

  Future<void> rename(int id, String name);

  Future<void> setActive(int id, {required bool isActive});
}

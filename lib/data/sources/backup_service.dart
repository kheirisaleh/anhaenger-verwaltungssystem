import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import '../../core/database/app_database.dart';
import '../../core/database/app_directories.dart';

class BackupService {
  BackupService(this._db, this._directories);

  final AppDatabase _db;
  final AppDirectories _directories;

  static const String folderPrefix = 'Anhaenger-Backup_';

  Future<Directory> export(Directory parent) async {
    final String stamp = DateFormat(
      'yyyy-MM-dd_HH-mm-ss',
      'en_US',
    ).format(DateTime.now());
    final Directory target = Directory(p.join(parent.path, '$folderPrefix$stamp'));
    final File databaseCopy = _databaseFileIn(target);
    await databaseCopy.parent.create(recursive: true);
    final String escaped = databaseCopy.path.replaceAll("'", "''");
    await _db.customStatement("VACUUM INTO '$escaped'");
    await _copyDirectory(
      _directories.imagesDirectory,
      Directory(p.join(target.path, 'images')),
    );
    return target;
  }

  static bool isBackupFolder(Directory folder) {
    return _databaseFileIn(folder).existsSync();
  }

  static Future<void> restoreFiles(
    Directory source,
    AppDirectories directories,
  ) async {
    final File database = directories.databaseFile;
    await database.parent.create(recursive: true);
    for (final String suffix in <String>['-wal', '-shm', '-journal']) {
      final File sidecar = File('${database.path}$suffix');
      if (await sidecar.exists()) {
        await sidecar.delete();
      }
    }
    await _databaseFileIn(source).copy(database.path);
    final Directory images = directories.imagesDirectory;
    if (await images.exists()) {
      await images.delete(recursive: true);
    }
    await _copyDirectory(Directory(p.join(source.path, 'images')), images);
  }

  static File _databaseFileIn(Directory folder) {
    return File(p.join(folder.path, 'database', 'app.sqlite'));
  }

  static Future<void> _copyDirectory(Directory source, Directory target) async {
    if (!await source.exists()) {
      return;
    }
    await target.create(recursive: true);
    await for (final FileSystemEntity entity in source.list(recursive: true)) {
      final String relative = p.relative(entity.path, from: source.path);
      final String destination = p.join(target.path, relative);
      if (entity is Directory) {
        await Directory(destination).create(recursive: true);
      } else if (entity is File) {
        await File(destination).parent.create(recursive: true);
        await entity.copy(destination);
      }
    }
  }
}

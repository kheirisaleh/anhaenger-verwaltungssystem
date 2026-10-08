import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../core/constants/app_strings.dart';
import '../core/formatting/csv.dart';
import '../data/sources/backup_service.dart';

abstract final class FileDialogs {
  static const XTypeGroup _images = XTypeGroup(
    label: AppStrings.fileTypeImages,
    extensions: <String>['jpg', 'jpeg', 'png', 'webp'],
    uniformTypeIdentifiers: <String>['public.image'],
    mimeTypes: <String>['image/*'],
  );

  static const XTypeGroup _csv = XTypeGroup(
    label: AppStrings.fileTypeCsv,
    extensions: <String>['csv'],
  );

  static bool get isMobile => Platform.isAndroid || Platform.isIOS;

  static Future<File?> pickImage() async {
    final XFile? file = await openFile(
      acceptedTypeGroups: <XTypeGroup>[_images],
    );
    return file == null ? null : File(file.path);
  }

  static Future<Directory?> pickDirectory() async {
    if (isMobile) {
      return exportDirectory();
    }
    final String? path = await getDirectoryPath(canCreateDirectories: true);
    return path == null ? null : Directory(path);
  }

  static Future<Directory?> pickBackupFolder() async {
    if (!isMobile) {
      return pickDirectory();
    }
    final Directory exports = await exportDirectory();
    final List<Directory> backups =
        exports
            .listSync()
            .whereType<Directory>()
            .where(
              (Directory d) =>
                  p.basename(d.path).startsWith(BackupService.folderPrefix),
            )
            .toList()
          ..sort((Directory a, Directory b) => b.path.compareTo(a.path));
    return backups.isEmpty ? null : backups.first;
  }

  static Future<Directory> exportDirectory() async {
    final Directory? external = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : null;
    final Directory base = external ?? await getApplicationDocumentsDirectory();
    final Directory directory = Directory(p.join(base.path, 'Export'));
    await directory.create(recursive: true);
    return directory;
  }

  static Future<File?> saveCsv(
    String suggestedName,
    List<List<String>> rows,
  ) async {
    final String? path = isMobile
        ? p.join((await exportDirectory()).path, suggestedName)
        : (await getSaveLocation(
            suggestedName: suggestedName,
            acceptedTypeGroups: <XTypeGroup>[_csv],
          ))?.path;
    if (path == null) {
      return null;
    }
    final File file = File(
      path.toLowerCase().endsWith('.csv') ? path : '$path.csv',
    );
    await file.writeAsString(Csv.encode(rows));
    return file;
  }
}

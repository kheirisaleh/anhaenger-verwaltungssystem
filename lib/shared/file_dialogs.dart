import 'dart:io';

import 'package:file_selector/file_selector.dart';

import '../core/constants/app_strings.dart';
import '../core/formatting/csv.dart';

abstract final class FileDialogs {
  static const XTypeGroup _images = XTypeGroup(
    label: AppStrings.fileTypeImages,
    extensions: <String>['jpg', 'jpeg', 'png', 'webp'],
  );

  static const XTypeGroup _csv = XTypeGroup(
    label: AppStrings.fileTypeCsv,
    extensions: <String>['csv'],
  );

  static Future<File?> pickImage() async {
    final XFile? file = await openFile(
      acceptedTypeGroups: <XTypeGroup>[_images],
    );
    return file == null ? null : File(file.path);
  }

  static Future<Directory?> pickDirectory() async {
    final String? path = await getDirectoryPath(canCreateDirectories: true);
    return path == null ? null : Directory(path);
  }

  static Future<File?> saveCsv(
    String suggestedName,
    List<List<String>> rows,
  ) async {
    final FileSaveLocation? location = await getSaveLocation(
      suggestedName: suggestedName,
      acceptedTypeGroups: <XTypeGroup>[_csv],
    );
    if (location == null) {
      return null;
    }
    final String path = location.path.toLowerCase().endsWith('.csv')
        ? location.path
        : '${location.path}.csv';
    final File file = File(path);
    await file.writeAsString(Csv.encode(rows));
    return file;
  }
}

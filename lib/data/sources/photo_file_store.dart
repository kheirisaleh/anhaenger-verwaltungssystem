import 'dart:io';

import 'package:path/path.dart' as p;

import '../../core/database/app_directories.dart';
import '../models/photo.dart';

class PhotoFileStore {
  PhotoFileStore(this._directories);

  final AppDirectories _directories;
  int _sequence = 0;

  Future<String> copyIn(PhotoOwner owner, File source) async {
    final String folder = switch (owner) {
      TrailerPhotoOwner() => 'trailers',
      DamagePhotoOwner() => 'damages',
    };
    final String extension = p.extension(source.path).toLowerCase();
    final String fileName =
        '${DateTime.now().microsecondsSinceEpoch}_${_sequence++}$extension';
    final String relativePath = p.posix.join(
      'images',
      folder,
      '${owner.id}',
      fileName,
    );
    final File target = resolve(relativePath);
    await target.parent.create(recursive: true);
    await source.copy(target.path);
    return relativePath;
  }

  Future<void> delete(String relativePath) async {
    final File file = resolve(relativePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  File resolve(String relativePath) =>
      File(_directories.absolutePath(relativePath));
}

import 'dart:io';

import '../models/photo.dart';

abstract interface class PhotoRepository {
  Stream<List<Photo>> watchFor(PhotoOwner owner);

  Future<Photo> add(PhotoOwner owner, File source);

  Future<void> replace(int photoId, File source);

  Future<void> delete(int photoId);

  File fileOf(Photo photo);
}

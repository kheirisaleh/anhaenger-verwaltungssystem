import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AppDirectories {
  const AppDirectories(this.root);

  final Directory root;

  static Future<AppDirectories> resolve() async {
    final Directory support = await getApplicationSupportDirectory();
    return AppDirectories(support);
  }

  File get databaseFile => File(p.join(root.path, 'database', 'app.sqlite'));

  Directory get imagesDirectory => Directory(p.join(root.path, 'images'));

  String absolutePath(String relativePath) =>
      p.joinAll(<String>[root.path, ...p.posix.split(relativePath)]);
}

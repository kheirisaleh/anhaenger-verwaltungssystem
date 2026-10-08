import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import '../core/constants/app_strings.dart';
import '../core/design/app_colors.dart';
import '../core/design/app_icons.dart';
import '../core/design/app_spacing.dart';
import '../core/design/app_typography.dart';
import '../core/design/widgets/app_button.dart';
import '../core/design/widgets/app_dialog.dart';
import '../core/design/widgets/app_icon_button.dart';
import '../core/design/widgets/app_messages.dart';
import '../data/models/photo.dart';
import '../data/repositories/photo_repository.dart';
import '../data/repositories/repository_exception.dart';
import 'app_dependencies.dart';
import 'file_dialogs.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key, required this.owner});

  final PhotoOwner owner;

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  Stream<List<Photo>>? _photos;
  bool _isBusy = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _photos ??= AppScope.of(context).photos.watchFor(widget.owner);
  }

  @override
  Widget build(BuildContext context) {
    final PhotoRepository repository = AppScope.of(context).photos;
    return StreamBuilder<List<Photo>>(
      stream: _photos,
      builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
        final List<Photo> photos = snapshot.data ?? const <Photo>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (photos.isEmpty)
              const Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(AppStrings.photosEmpty, style: AppText.bodyMuted),
              )
            else
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: <Widget>[
                    for (final Photo photo in photos)
                      _PhotoTile(
                        file: repository.fileOf(photo),
                        onReplace: _isBusy
                            ? null
                            : () => _replace(repository, photo),
                        onDelete: _isBusy
                            ? null
                            : () => _delete(repository, photo),
                      ),
                  ],
                ),
              ),
            AppButton(
              label: AppStrings.photoAdd,
              icon: AppIcons.photo,
              isLoading: _isBusy,
              onPressed: () => _add(repository),
            ),
          ],
        );
      },
    );
  }

  Future<void> _add(PhotoRepository repository) async {
    final File? file = await FileDialogs.pickImage();
    if (file == null) {
      return;
    }
    await _run(() => repository.add(widget.owner, file));
  }

  Future<void> _replace(PhotoRepository repository, Photo photo) async {
    final File? file = await FileDialogs.pickImage();
    if (file == null) {
      return;
    }
    await _run(() => repository.replace(photo.id, file));
  }

  Future<void> _delete(PhotoRepository repository, Photo photo) async {
    final bool confirmed = await AppDialog.confirmDelete(context);
    if (!confirmed) {
      return;
    }
    await _run(() => repository.delete(photo.id));
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _isBusy = true);
    try {
      await action();
    } on RepositoryException catch (error) {
      if (mounted) {
        AppMessages.error(context, error.message);
      }
    } on FileSystemException {
      if (mounted) {
        AppMessages.error(context, AppStrings.errorFile);
      }
    } finally {
      if (mounted) {
        setState(() => _isBusy = false);
      }
    }
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.file, this.onReplace, this.onDelete});

  final File file;
  final VoidCallback? onReplace;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 120,
            width: 180,
            child: Image.file(
              file,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stack) =>
                      const Center(
                        child: Icon(
                          AppIcons.photo,
                          size: AppSizes.iconState,
                          color: AppColors.textDisabled,
                        ),
                      ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              AppIconButton(
                icon: AppIcons.edit,
                tooltip: AppStrings.photoReplace,
                onPressed: onReplace,
              ),
              AppIconButton(
                icon: AppIcons.delete,
                tooltip: AppStrings.actionDelete,
                isDestructive: true,
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

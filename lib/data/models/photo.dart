class Photo {
  const Photo({
    required this.id,
    required this.filePath,
    required this.sortOrder,
    required this.createdAt,
    this.trailerId,
    this.damageRecordId,
  });

  final int id;
  final int? trailerId;
  final int? damageRecordId;
  final String filePath;
  final int sortOrder;
  final DateTime createdAt;
}

sealed class PhotoOwner {
  const PhotoOwner(this.id);

  final int id;
}

final class TrailerPhotoOwner extends PhotoOwner {
  const TrailerPhotoOwner(super.id);
}

final class DamagePhotoOwner extends PhotoOwner {
  const DamagePhotoOwner(super.id);
}

import 'package:book_shelf/models/volume_info_model.dart';

class BookItem {
  final String kind;
  final String id;
  final String etag;
  final String selfLink;
  final VolumeInfo volumeInfo;

  BookItem({
    required this.kind,
    required this.id,
    required this.etag,
    required this.selfLink,
    required this.volumeInfo,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      kind: json['kind'] ?? '',
      id: json['id'] ?? '',
      etag: json['etag'] ?? '',
      selfLink: json['selfLink'] ?? '',
      volumeInfo: VolumeInfo.fromJson(json['volumeInfo'] ?? {}),
    );
  }
}

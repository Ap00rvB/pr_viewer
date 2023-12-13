import 'book_item_model.dart';

class BookModel {
  final String kind;
  final int totalItems;
  final List<BookItem> items;

  BookModel({
    required this.kind,
    required this.totalItems,
    required this.items,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      kind: json['kind'] ?? '',
      totalItems: json['totalItems'] ?? 0,
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => BookItem.fromJson(item))
          .toList() ??
          [],
    );
  }
}
import 'book_model.dart';

class BooksResponse {
  final String? error;
  final String? total;
  final List<BookModel>? books;

  BooksResponse({
    required this.error,
    required this.total,
    required this.books,
  });

  factory BooksResponse.fromJson(Map<String, dynamic> json) {
    return BooksResponse(
      error: json['error'],
      total: json['total'],
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => BookModel.fromJson(e))
          .toList(),
    );
  }
}

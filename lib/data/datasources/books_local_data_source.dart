import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/book_model.dart';
import 'hive_books_data_source.dart';

abstract class BooksLocalDataSource {
  bool contains(String id);

  Future<void> addBook(BookModel bookModel);

  Future<void> updateBook(String oldId, BookModel bookModel);

  Future<void> deleteBook(String id);

  Iterable<BookModel> get books;
}

final bookmarksBoxProvider = Provider<Box<BookModel>>((ref) {
  throw UnimplementedError();
});

final booksLocalDataSourceProvider = Provider<BooksLocalDataSource>((ref) {
  return HiveBooksDataSource(ref.read(bookmarksBoxProvider));
});

import '../../../../features/books/data/models/book_model.dart';

abstract class LocalDatabase {
  bool contains(String id);

  Future<void> addBook(BookModel bookModel);

  Future<void> updateBook(String oldId, BookModel bookModel);

  Future<void> deleteBook(String id);

  Iterable<BookModel> get books;
}

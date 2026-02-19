import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/book.dart';
import '../../domain/repositories/bookmarks_repository.dart';
import '../datasources/books_local_data_source.dart';
import '../models/book_model.dart';

class BookmarksRepositoryImpl implements BookmarksRepository {
  final BooksLocalDataSource localDataSource;

  BookmarksRepositoryImpl(this.localDataSource);

  @override
  List<Book> getBookmarks() {
    return localDataSource.books
        .map((bookModel) => bookModel.toBook())
        .toList();
  }

  @override
  bool isBookmarked(String id) {
    return localDataSource.contains(id);
  }

  @override
  Future<void> toggleBookmark(Book book) async {
    if (isBookmarked(book.id)) {
      await localDataSource.deleteBook(book.id);
    } else {
      await localDataSource.addBook(BookModel.fromBook(book));
    }
  }
}

final bookmarksRepositoryProvider = Provider<BookmarksRepository>((ref) {
  return BookmarksRepositoryImpl(ref.read(booksLocalDataSourceProvider));
});

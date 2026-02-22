import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/book.dart';
import '../../domain/repositories/bookmarks_repository.dart';
import '../models/book_model.dart';
import '../services/local/database/hive_service.dart';
import '../services/local/database/local_database.dart';

class BookmarksRepositoryImpl implements BookmarksRepository {
  final LocalDatabase _database;

  BookmarksRepositoryImpl(this._database);

  @override
  List<Book> getBookmarks() {
    return _database.books.map((bookModel) => bookModel.toBook()).toList();
  }

  @override
  bool isBookmarked(String id) {
    return _database.contains(id);
  }

  @override
  Future<void> toggleBookmark(Book book) async {
    if (isBookmarked(book.id)) {
      await _database.deleteBook(book.id);
    } else {
      await _database.addBook(BookModel.fromBook(book));
    }
  }
}

final bookmarksRepositoryProvider = Provider<BookmarksRepository>((ref) {
  return BookmarksRepositoryImpl(ref.read(localDatabaseProvider));
});

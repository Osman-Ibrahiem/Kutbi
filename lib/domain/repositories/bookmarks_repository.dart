import '../models/book.dart';

abstract class BookmarksRepository {
  List<Book> getBookmarks();

  Future<void> toggleBookmark(Book book);

  bool isBookmarked(String id);
}

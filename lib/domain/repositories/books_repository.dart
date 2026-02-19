import 'package:kutbi/domain/models/book.dart';

abstract class BooksRepository {
  Future<List<Book>> getNewBooks();

  Future<Book> getBookDetails(String isbn);
}

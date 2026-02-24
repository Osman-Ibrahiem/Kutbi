import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/api_exception.dart';
import '../../domain/models/book.dart';
import '../../domain/repositories/books_repository.dart';
import '../datasources/books_remote_data_source.dart';

class BooksRepositoryImpl implements BooksRepository {
  final BooksRemoteDataSource remoteDataSource;

  BooksRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Book>> getNewBooks() async {
    try {
      final remoteBooks = await remoteDataSource.fetchNewBooks();
      final books = remoteBooks.map((e) => e.toBook()).toList();
      return books;
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      } else if (e is FormatException || e is DataParsingException) {
        throw DataParsingException(message: "Bad Data Format from Server");
      } else {
        throw ServerException(message: "Unexpected Error: $e");
      }
    }
  }

  @override
  Future<Book> getBookDetails(String isbn) async {
    try {
      final remoteBook = await remoteDataSource.getBookDetails(isbn);
      final book = remoteBook.toBook();
      return book;
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ServerException(message: "Unexpected Error: $e");
    }
  }
}

final booksRepositoryProvider = Provider<BooksRepository>((ref) {
  return BooksRepositoryImpl(
    remoteDataSource: ref.read(booksRemoteDataSourceProvider),
  );
});

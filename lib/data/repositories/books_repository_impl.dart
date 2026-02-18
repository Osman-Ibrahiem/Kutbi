import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/errors/exceptions.dart';
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
      if (e is SocketException) {
        throw OfflineException("No Internet and no cached data.");
      } else if (e is ServerException) {
        rethrow;
      } else if (e is OfflineException) {
        rethrow;
      } else if (e is FormatException || e is DataParsingException) {
        throw DataParsingException("Bad Data Format from Server");
      } else {
        throw ServerException("Unexpected Error: $e");
      }
    }
  }
}

final booksRepositoryProvider = Provider<BooksRepository>((ref) {
  return BooksRepositoryImpl(
    remoteDataSource: ref.read(booksRemoteDataSourceProvider),
  );
});

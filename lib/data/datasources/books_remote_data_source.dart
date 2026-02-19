import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/api_service.dart';
import '../models/book_model.dart';
import '../models/books_response.dart';

class BooksRemoteDataSource {
  final ApiService apiService;

  BooksRemoteDataSource({required this.apiService});

  Future<List<BookModel>> fetchNewBooks() async {
    final response = await apiService.get(endpoint: 'new');

    try {
      final booksResponse = BooksResponse.fromJson(response);

      if (booksResponse.error != "0") {
        throw ServerException("API Error: ${booksResponse.error}");
      }

      if (booksResponse.books == null || booksResponse.books!.isEmpty) {
        throw EmptyDataException();
      }

      return booksResponse.books ?? [];
    } catch (e) {
      throw DataParsingException("Failed to parse books response: $e");
    }
  }

  Future<BookModel> getBookDetails(String isbn) async {
    final response = await apiService.get(endpoint: '/books/$isbn');

    try {
      return BookModel.fromJson(response);
    } catch (e) {
      throw DataParsingException("Failed to parse book details: $e");
    }
  }
}

final booksRemoteDataSourceProvider = Provider<BooksRemoteDataSource>(
  (ref) => BooksRemoteDataSource(apiService: ref.read(apiServiceProvider)),
);

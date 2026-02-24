import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/utils/api_exception.dart';

import '../../../../core/services/remote/api/api_client.dart';
import '../../../../core/services/remote/api/http_client.dart';
import '../models/book_model.dart';
import '../models/books_response.dart';

class BooksRemoteDataSource {
  final ApiClient _apiClient;

  BooksRemoteDataSource(this._apiClient);

  Future<List<BookModel>> fetchNewBooks() async {
    final response = await _apiClient.get(endpoint: 'new');

    try {
      final booksResponse = BooksResponse.fromJson(response);

      if (booksResponse.error != "0") {
        throw ServerException(message: "API Error: ${booksResponse.error}");
      }

      return booksResponse.books ?? [];
    } on ApiException {
      rethrow;
    } catch (e) {
      throw DataParsingException(message: "Failed to parse books response: $e");
    }
  }

  Future<BookModel> getBookDetails(String isbn) async {
    final response = await _apiClient.get(endpoint: '/books/$isbn');

    try {
      return BookModel.fromJson(response);
    } catch (e) {
      throw DataParsingException(message: "Failed to parse book details: $e");
    }
  }
}

final booksRemoteDataSourceProvider = Provider<BooksRemoteDataSource>(
  (ref) => BooksRemoteDataSource(ref.read(apiClientProvider)),
);

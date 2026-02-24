import 'package:flutter_test/flutter_test.dart';
import 'package:kutbi/core/utils/api_exception.dart';
import 'package:kutbi/features/books/data/datasources/books_remote_data_source.dart';
import 'package:kutbi/features/books/data/models/book_model.dart';
import 'package:kutbi/features/books/data/repositories/books_repository_impl.dart';
import 'package:kutbi/features/books/domain/repositories/books_repository.dart';
import 'package:mocktail/mocktail.dart';

class BooksRemoteDataSourceMock extends Mock implements BooksRemoteDataSource {}

void main() {
  late BooksRepository repository;
  late BooksRemoteDataSourceMock booksRemoteDataSourceMock;

  setUp(() {
    booksRemoteDataSourceMock = BooksRemoteDataSourceMock();
    repository = BooksRepositoryImpl(
      remoteDataSource: booksRemoteDataSourceMock,
    );
  });

  group('BooksRepository', () {
    final testBookModel = BookModel(title: 'Title', isbn13: '123');

    group('getNewBooks', () {
      test('should return list of mapped domain books safely', () async {
        when(
          () => booksRemoteDataSourceMock.fetchNewBooks(),
        ).thenAnswer((_) async => [testBookModel]);

        final result = await repository.getNewBooks();

        expect(result.length, 1);
        expect(result.first.id, '123');
      });

      test('should rethrow ApiException directly', () async {
        when(
          () => booksRemoteDataSourceMock.fetchNewBooks(),
        ).thenThrow(ServerException(message: 'Error'));

        expect(() => repository.getNewBooks(), throwsA(isA<ServerException>()));
      });

      test('should map FormatException to DataParsingException', () async {
        when(
          () => booksRemoteDataSourceMock.fetchNewBooks(),
        ).thenThrow(const FormatException('Bad'));

        expect(
          () => repository.getNewBooks(),
          throwsA(isA<DataParsingException>()),
        );
      });

      test('should map unknown exception to ServerException', () async {
        when(
          () => booksRemoteDataSourceMock.fetchNewBooks(),
        ).thenThrow(Exception('Unknown'));

        expect(() => repository.getNewBooks(), throwsA(isA<ServerException>()));
      });
    });
  });
}

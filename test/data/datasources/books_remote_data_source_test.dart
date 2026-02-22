import 'package:flutter_test/flutter_test.dart';
import 'package:kutbi/core/utils/api_exception.dart';
import 'package:kutbi/data/datasources/books_remote_data_source.dart';
import 'package:kutbi/data/services/remote/api/api_client.dart';
import 'package:mocktail/mocktail.dart';

class ApiClientMock extends Mock implements ApiClient {}

void main() {
  late BooksRemoteDataSource dataSource;
  late ApiClientMock apiClientMock;

  setUp(() {
    apiClientMock = ApiClientMock();
    dataSource = BooksRemoteDataSource(apiClientMock);
  });

  group('BooksRemoteDataSource', () {
    group('fetchNewBooks', () {
      const testBooksResponseMap = {
        'error': '0',
        'total': '1',
        'books': [
          {'title': 'Book 1', 'isbn13': '123'},
        ],
      };

      test('should return list of BookModel when response code is 0', () async {
        when(
          () => apiClientMock.get(endpoint: any(named: 'endpoint')),
        ).thenAnswer((_) async => testBooksResponseMap);

        final result = await dataSource.fetchNewBooks();
        expect(result, isNotEmpty);
        expect(result.first.title, 'Book 1');
      });

      test(
        'should throw ServerException when response error is not 0',
        () async {
          final errorResponse = {'error': '1', 'total': '0', 'books': []};
          when(
            () => apiClientMock.get(endpoint: any(named: 'endpoint')),
          ).thenAnswer((_) async => errorResponse);

          expect(
            () => dataSource.fetchNewBooks(),
            throwsA(isA<ServerException>()),
          );
        },
      );

      test('should throw ServerException when JSON is invalid', () async {
        when(
          () => apiClientMock.get(endpoint: any(named: 'endpoint')),
        ).thenAnswer((_) async => {'invalid': 'format'});

        expect(
          () => dataSource.fetchNewBooks(),
          throwsA(isA<ServerException>()),
        );
      });
    });
  });
}

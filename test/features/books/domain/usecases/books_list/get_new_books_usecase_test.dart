import 'package:flutter_test/flutter_test.dart';
import 'package:kutbi/features/books/domain/models/book.dart';
import 'package:kutbi/features/books/domain/repositories/books_repository.dart';
import 'package:kutbi/features/books/domain/usecases/books_list/get_new_books_usecase.dart';
import 'package:mocktail/mocktail.dart';

class BooksRepositoryMock extends Mock implements BooksRepository {}

void main() {
  late GetNewBooksUseCase useCase;
  late BooksRepositoryMock repositoryMock;

  setUp(() {
    repositoryMock = BooksRepositoryMock();
    useCase = GetNewBooksUseCase(repositoryMock);
  });

  group('GetNewBooksUseCase', () {
    final testBooks = [
      const Book(
        id: '123',
        title: 'Test title',
        subTitle: 'Test subTitle',
        authors: 'Test authors',
        publisher: 'Test publisher',
        pages: '100',
        year: '2026',
        rating: '5',
        desc: 'Test desc',
        price: '\$25',
        imageUrl: '',
        url: '',
      ),
    ];

    test('should get list of new books from the repository', () async {
      when(
        () => repositoryMock.getNewBooks(),
      ).thenAnswer((_) async => testBooks);

      final result = await useCase();

      expect(result, equals(testBooks));
      verify(() => repositoryMock.getNewBooks()).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });

    test('should rethrow exceptions from the repository', () async {
      when(
        () => repositoryMock.getNewBooks(),
      ).thenThrow(Exception('Server error'));

      expect(() => useCase(), throwsA(isA<Exception>()));
    });
  });
}

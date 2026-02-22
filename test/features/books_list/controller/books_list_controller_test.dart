import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kutbi/domain/models/book.dart';
import 'package:kutbi/domain/usecases/books_list/get_new_books_usecase.dart';
import 'package:kutbi/features/books_list/controller/books_list_controller.dart';
import 'package:kutbi/features/books_list/state/books_list_state.dart';
import 'package:mocktail/mocktail.dart';

class GetNewBooksUseCaseMock extends Mock implements GetNewBooksUseCase {}

void main() {
  late GetNewBooksUseCaseMock useCaseMock;

  setUp(() {
    useCaseMock = GetNewBooksUseCaseMock();
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [getNewBooksUseCaseProvider.overrideWithValue(useCaseMock)],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('BooksListController', () {
    final testBook = Book(
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
    );

    test('initial state should be Initial', () {
      when(() => useCaseMock()).thenAnswer((_) async => []);
      final container = createContainer();
      expect(container.read(booksListControllerProvider), isA<Initial>());
    });

    test('getNewBooks should emit Loading then Loaded on success', () async {
      when(() => useCaseMock()).thenAnswer((_) async => [testBook]);

      final container = createContainer();

      final states = <BooksListState>[];
      container.listen(
        booksListControllerProvider,
        (previous, next) => states.add(next),
        fireImmediately: true,
      );

      final notifier = container.read(booksListControllerProvider.notifier);
      await notifier.getNewBooks();

      expect(states.any((s) => s is Loading), isTrue);
      expect(states.last, isA<Loaded>());
      expect((states.last as Loaded).books, [testBook]);
    });

    test('getNewBooks should emit Loading then Failure on error', () async {
      when(() => useCaseMock()).thenThrow(Exception('Error'));

      final container = createContainer();

      final notifier = container.read(booksListControllerProvider.notifier);
      await notifier.getNewBooks();

      final state = container.read(booksListControllerProvider);
      expect(state, isA<Failure>());
      expect((state as Failure).message, 'Failed to fetch books');
    });

    test(
      'getNewBooks with isRefreshing=true should not emit Loading',
      () async {
        when(() => useCaseMock()).thenAnswer((_) async => [testBook]);

        final container = createContainer();
        final notifier = container.read(booksListControllerProvider.notifier);
        await notifier.getNewBooks(); // Wait for initial fetch

        // Reset mock to spy on subsequent call
        clearInteractions(useCaseMock);
        when(() => useCaseMock()).thenAnswer((_) async => []);

        final states = <BooksListState>[];
        container.listen(
          booksListControllerProvider,
          (_, next) => states.add(next),
        );

        await notifier.getNewBooks(isRefreshing: true);

        expect(states.any((s) => s is Loading), isFalse);
        expect(states.last, isA<Loaded>());
      },
    );
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/books_list/get_new_books_usecase.dart';
import '../state/books_list_state.dart';

class BooksListController extends Notifier<BooksListState> {
  late final GetNewBooksUseCase _getNewBooksUseCase;

  @override
  BooksListState build() {
    _getNewBooksUseCase = ref.read(getNewBooksUseCaseProvider);
    Future.microtask(() => getNewBooks());
    return Initial();
  }

  Future<void> getNewBooks({bool isRefreshing = false}) async {
    if (state is Loading) return;

    if (!isRefreshing) {
      state = Loading();
    }

    try {
      final books = await _getNewBooksUseCase();
      state = Loaded(books);
    } catch (e) {
      state = Failure("Failed to fetch books");
    }
  }
}

final booksListControllerProvider =
    NotifierProvider<BooksListController, BooksListState>(
      BooksListController.new,
    );

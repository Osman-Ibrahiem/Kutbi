import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/error_layout.dart';
import '../../../domain/models/book.dart';
import '../controller/books_list_controller.dart';
import '../state/books_list_state.dart';
import 'books_list_view.dart';

class BooksListScreenBody extends ConsumerWidget {
  const BooksListScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch<BooksListState>(booksListControllerProvider);
    return switch (state) {
      Loading() => BooksListView(
        books: List.filled(7, Book.dummy),
        isLoading: true,
      ),
      Loaded(books: final books) => RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(booksListControllerProvider.notifier)
              .getNewBooks(isRefreshing: true);
        },
        child: BooksListView(books: books),
      ),
      Failure(message: final message) => ErrorLayout.unknownError(
        message: message,
        onRetry: () {
          ref.read(booksListControllerProvider.notifier).getNewBooks();
        },
      ),
      _ => const SizedBox(),
    };
  }
}

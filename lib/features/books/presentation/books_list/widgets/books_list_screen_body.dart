import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/secondary_button.dart';
import '../../../domain/models/book.dart';
import '../controller/books_list_controller.dart';
import '../state/books_list_state.dart';
import 'book_card.dart';

class BooksListScreenBody extends ConsumerWidget {
  const BooksListScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch<BooksListState>(booksListControllerProvider);
    return switch (state) {
      Loading() => Center(child: const CircularProgressIndicator()),
      Loaded(books: final books) => RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(booksListControllerProvider.notifier)
              .getNewBooks(isRefreshing: true);
        },
        child: _buildBooksList(context, books: books),
      ),
      Failure(message: final message) => Center(
        child: Column(
          children: [
            Text(message, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            SecondaryButton.text(
              onPressed: () {
                ref.read(booksListControllerProvider.notifier).getNewBooks();
              },
              text: "Try Again",
            ),
          ],
        ),
      ),
      _ => const SizedBox(),
    };
  }

  Widget _buildBooksList(BuildContext context, {required List<Book> books}) {
    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: books.length,
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 12 + MediaQuery.of(context).padding.bottom,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 270,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.70,
      ),
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCard(
          book: book,
          onTap: () {
            if (!context.mounted) return;
            Navigator.pushNamed(
              context,
              AppRoutes.bookDetails,
              arguments: book.id,
            );
          },
        );
      },
    );
  }
}

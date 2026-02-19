import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/routing/app_routes.dart';

import '../../../domain/models/book.dart';
import '../../books_list/widgets/book_card.dart';
import '../controller/bookmarks_controller.dart';

class BookmarksScreenBody extends ConsumerWidget {
  const BookmarksScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksControllerProvider);

    return bookmarks.isEmpty
        ? const Center(child: Text("No bookmarks yet."))
        : _buildBooksList(context, books: bookmarks);
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

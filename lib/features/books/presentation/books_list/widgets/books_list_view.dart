import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/routing/app_routes.dart';
import '../../../domain/models/book.dart';
import 'book_card.dart';

class BooksListView extends StatelessWidget {
  final List<Book> books;
  final bool isLoading;

  const BooksListView({super.key, required this.books, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
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
      ),
    );
  }
}

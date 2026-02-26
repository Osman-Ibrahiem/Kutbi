import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/generated/l10n.dart';
import '../../../../core/widgets/error_layout.dart';
import '../../../books/presentation/books_list/widgets/books_list_view.dart';
import '../controller/bookmarks_controller.dart';

class BookmarksScreenBody extends ConsumerWidget {
  const BookmarksScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksControllerProvider);

    return bookmarks.isEmpty
        ? ErrorLayout.empty(
            icon: Icons.bookmarks_outlined,
            title: S.of(context).noBookmarks,
          )
        : BooksListView(books: bookmarks);
  }
}

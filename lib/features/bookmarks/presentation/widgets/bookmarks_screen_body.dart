import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/generated/l10n.dart';
import '../../../books/presentation/books_list/widgets/books_list_view.dart';
import '../controller/bookmarks_controller.dart';

class BookmarksScreenBody extends ConsumerWidget {
  const BookmarksScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksControllerProvider);

    return bookmarks.isEmpty
        ? Center(child: Text(S.of(context).noBookmarks))
        : BooksListView(books: bookmarks);
  }
}

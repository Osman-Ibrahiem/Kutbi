import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/theme/app_colors.dart';
import 'package:kutbi/core/widgets/app_snackbar.dart';

import '../../../domain/models/book.dart';
import '../controller/bookmarks_controller.dart';

class BookmarkButton extends ConsumerWidget {
  final Book book;

  const BookmarkButton({super.key, required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmarked = ref.watch(isBookmarkedProvider(book.id));

    return IconButton(
      icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
      color: isBookmarked ? AppColors.primary : AppColors.grey,
      onPressed: () {
        ref.read(bookmarksControllerProvider.notifier).toggle(book);

        AppSnackBar.showSuccess(
          context,
          isBookmarked ? 'Removed from bookmarks' : 'Added to bookmarks',
        );
      },
    );
  }
}

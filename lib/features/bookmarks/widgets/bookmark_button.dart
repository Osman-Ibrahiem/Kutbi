import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/l10n.dart';
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

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    return IconButton(
      icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
      color: isBookmarked ? AppColors.primary : AppColors.grey,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor.withAlpha(50),
      ),
      onPressed: () {
        ref.read(bookmarksControllerProvider.notifier).toggle(book);

        AppSnackBar.showSuccess(
          context,
          isBookmarked
              ? S.of(context).bookmarks_removed
              : S.of(context).bookmarks_added,
        );
      },
    );
  }
}

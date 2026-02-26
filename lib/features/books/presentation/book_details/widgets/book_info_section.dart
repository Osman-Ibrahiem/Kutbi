import 'package:flutter/material.dart';

import '../../../../../core/generated/l10n.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/models/book.dart';

class BookInfoSection extends StatelessWidget {
  final Book book;

  const BookInfoSection({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(book.authors, style: textTheme.bodyMedium),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...List.generate(
                  (int.tryParse(book.rating) ?? 0),
                  (index) => const Icon(
                    Icons.star,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 6),
                Text("(${book.rating})"),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _InfoBox(
                    title: S.of(context).publicationYear,
                    value: book.year,
                    icon: Icons.calendar_today_rounded,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _InfoBox(
                    title: S.of(context).price,
                    value: book.price,
                    icon: Icons.price_check_rounded,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _InfoBox(
                    title: S.of(context).pages,
                    value: book.pages,
                    icon: Icons.menu_book_rounded,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoBox({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/theme/app_colors.dart';

import '../widgets/books_list_screen_body.dart';

class BooksListScreen extends StatelessWidget {
  const BooksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).appTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              S.of(context).appSubTitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      )
      ,
      body: const BooksListScreenBody(),
    );
  }
}

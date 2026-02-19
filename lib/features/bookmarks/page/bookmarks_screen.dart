import 'package:flutter/material.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/theme/app_colors.dart';

import '../widgets/bookmarks_screen_body.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).appTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: const BookmarksScreenBody(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../bookmarks/widgets/bookmark_button.dart';
import '../controller/book_details_controller.dart';
import '../widgets/book_details_screen_body.dart';

class BookDetailsScreen extends ConsumerWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookId = ModalRoute.of(context)!.settings.arguments as String;
    final state = ref.watch(bookDetailsProvider(bookId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final state = ref.read(bookDetailsProvider(bookId));
              if (state.hasValue && state.value != null) {
                final book = state.value!;
                return BookmarkButton(book: book);
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
        data: (book) => BookDetailsScreenBody(book: book),
      ),
    );
  }
}

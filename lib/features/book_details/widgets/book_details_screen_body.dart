import 'package:flutter/material.dart';
import 'package:kutbi/domain/models/book.dart';

import 'book_description_section.dart';
import 'book_header_section.dart';
import 'book_info_section.dart';

class BookDetailsScreenBody extends StatelessWidget {
  final Book book;

  const BookDetailsScreenBody({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookHeaderSection(imageUrl: book.imageUrl),
          Transform.translate(
            offset: const Offset(0, -50),
            child: Column(
              children: [
                const SizedBox(height: 16),
                BookInfoSection(book: book),
                const SizedBox(height: 16),
                BookDescriptionSection(description: book.desc),
                const SizedBox(height: 16),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

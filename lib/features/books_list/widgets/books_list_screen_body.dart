import 'package:flutter/material.dart';
import 'package:kutbi/domain/models/book.dart';

import 'book_card.dart';

class BooksListScreenBody extends StatelessWidget {
  const BooksListScreenBody({super.key});

  static const _demoBooks = <Book>[
    Book(
      id: "1",
      title: 'رياض الصالحين',
      subTitle: 'الإمام النووي',
      price: "4.9",
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&q=80',
    ),
    Book(
      id: "2",
      title: 'ألف ليلة وليلة',
      subTitle: 'مؤلف مجهول',
      price: "4.8",
      imageUrl:
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&q=80',
    ),
    Book(
      id: "3",
      title: 'Atomic Habits',
      subTitle: 'James Clear',
      price: "4.7",
      imageUrl:
          'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=800&q=80',
    ),
    Book(
      id: "4",
      title: 'The Alchemist',
      subTitle: 'Paulo Coelho',
      price: "4.6",
      imageUrl:
          'https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=800&q=80',
    ),
    Book(
      id: "5",
      title: 'رياض الصالحين',
      subTitle: 'الإمام النووي',
      price: "4.9",
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&q=80',
    ),
    Book(
      id: "6",
      title: 'ألف ليلة وليلة',
      subTitle: 'مؤلف مجهول',
      price: "4.8",
      imageUrl:
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&q=80',
    ),
    Book(
      id: "7",
      title: 'Atomic Habits',
      subTitle: 'James Clear',
      price: "4.7",
      imageUrl:
          'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=800&q=80',
    ),
    Book(
      id: "8",
      title: 'The Alchemist',
      subTitle: 'Paulo Coelho',
      price: "4.6",
      imageUrl:
          'https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=800&q=80',
    ),
    Book(
      id: "9",
      title: 'رياض الصالحين',
      subTitle: 'الإمام النووي',
      price: "4.9",
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&q=80',
    ),
    Book(
      id: "10",
      title: 'ألف ليلة وليلة',
      subTitle: 'مؤلف مجهول',
      price: "4.8",
      imageUrl:
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&q=80',
    ),
    Book(
      id: "11",
      title: 'Atomic Habits',
      subTitle: 'James Clear',
      price: "4.7",
      imageUrl:
          'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=800&q=80',
    ),
    Book(
      id: "12",
      title: 'The Alchemist',
      subTitle: 'Paulo Coelho',
      price: "4.6",
      imageUrl:
          'https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=800&q=80',
    ),
    Book(
      id: "13",
      title: 'رياض الصالحين',
      subTitle: 'الإمام النووي',
      price: "4.9",
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&q=80',
    ),
    Book(
      id: "14",
      title: 'ألف ليلة وليلة',
      subTitle: 'مؤلف مجهول',
      price: "4.8",
      imageUrl:
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800&q=80',
    ),
    Book(
      id: "15",
      title: 'Atomic Habits',
      subTitle: 'James Clear',
      price: "4.7",
      imageUrl:
          'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=800&q=80',
    ),
    Book(
      id: "16",
      title: 'The Alchemist',
      subTitle: 'Paulo Coelho',
      price: "4.6",
      imageUrl:
          'https://images.unsplash.com/photo-1528207776546-365bb710ee93?w=800&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _demoBooks.length,
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
        final book = _demoBooks[index];
        return BookCard(book: book, onTap: () {});
      },
    );
  }
}

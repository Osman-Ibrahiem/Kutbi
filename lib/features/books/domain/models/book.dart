class Book {
  final String id;
  final String title;
  final String subTitle;
  final String authors;
  final String publisher;
  final String pages;
  final String year;
  final String rating;
  final String desc;
  final String imageUrl;
  final String price;
  final String url;
  final Map<String, String>? pdf;

  const Book({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.authors,
    required this.publisher,
    required this.pages,
    required this.year,
    required this.rating,
    required this.desc,
    required this.imageUrl,
    required this.price,
    required this.url,
    this.pdf,
  });
}

import '../../domain/models/book.dart';

class BookModel {
  final String? title;
  final String? subtitle;
  final String? isbn10;
  final String? isbn13;
  final String? authors;
  final String? publisher;
  final String? pages;
  final String? year;
  final String? rating;
  final String? desc;
  final String? price;
  final String? image;
  final String? url;
  final Map<String, String>? pdf;

  BookModel({
    this.title,
    this.subtitle,
    this.isbn10,
    this.isbn13,
    this.authors,
    this.publisher,
    this.pages,
    this.year,
    this.rating,
    this.desc,
    this.price,
    this.image,
    this.url,
    this.pdf,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'],
      subtitle: json['subtitle'],
      authors: json['authors'],
      publisher: json['publisher'],
      isbn10: json['isbn10'],
      isbn13: json['isbn13'],
      pages: json['pages'],
      year: json['year'],
      rating: json['rating'],
      desc: json['desc'],
      price: json['price'],
      image: json['image'],
      url: json['url'],
      pdf: json['pdf'] != null ? Map<String, String>.from(json['pdf']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'authors': authors,
      'publisher': publisher,
      'isbn10': isbn10,
      'isbn13': isbn13,
      'pages': pages,
      'year': year,
      'rating': rating,
      'desc': desc,
      'price': price,
      'image': image,
      'url': url,
      'pdf': pdf,
    };
  }

  factory BookModel.fromBook(Book book) {
    return BookModel(
      isbn13: book.id,
      title: book.title,
      subtitle: book.subTitle,
      authors: book.authors,
      publisher: book.publisher,
      pages: book.pages,
      year: book.year,
      rating: book.rating,
      desc: book.desc,
      price: book.price,
      image: book.imageUrl,
      url: book.url,
      pdf: book.pdf,
    );
  }

  Book toBook() {
    return Book(
      id: isbn13 ?? '0',
      title: title ?? '',
      subTitle: subtitle ?? '',
      authors: authors ?? '',
      publisher: publisher ?? '',
      pages: pages ?? '',
      year: year ?? '',
      rating: rating ?? '',
      desc: desc ?? '',
      imageUrl: image ?? '',
      price: price ?? '',
      url: url ?? '',
      pdf: pdf,
    );
  }
}

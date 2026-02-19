import 'package:hive/hive.dart';

import 'book_model.dart';

class BookHiveAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    return BookModel(
      title: reader.read(),
      subtitle: reader.read(),
      isbn10: reader.read(),
      isbn13: reader.read(),
      authors: reader.read(),
      publisher: reader.read(),
      pages: reader.read(),
      year: reader.read(),
      rating: reader.read(),
      desc: reader.read(),
      price: reader.read(),
      image: reader.read(),
      url: reader.read(),
      pdf: (reader.read() as Map?)?.cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookModel bookModel) {
    writer
      ..write(bookModel.title)
      ..write(bookModel.subtitle)
      ..write(bookModel.isbn10)
      ..write(bookModel.isbn13)
      ..write(bookModel.authors)
      ..write(bookModel.publisher)
      ..write(bookModel.pages)
      ..write(bookModel.year)
      ..write(bookModel.rating)
      ..write(bookModel.desc)
      ..write(bookModel.price)
      ..write(bookModel.image)
      ..write(bookModel.url)
      ..write(bookModel.pdf);
  }
}

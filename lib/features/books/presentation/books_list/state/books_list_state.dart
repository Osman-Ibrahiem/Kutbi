import '../../../domain/models/book.dart';

abstract class BooksListState {}

class Initial extends BooksListState {}

class Loading extends BooksListState {}

class Loaded extends BooksListState {
  final List<Book> books;

  Loaded(this.books);
}

class Failure extends BooksListState {
  final String message;

  Failure(this.message);
}

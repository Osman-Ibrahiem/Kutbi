import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/books_repository_impl.dart';
import '../../models/book.dart';
import '../../repositories/books_repository.dart';

class GetBookDetailsUseCase {
  final BooksRepository repository;

  GetBookDetailsUseCase(this.repository);

  Future<Book> call(String isbn) {
    return repository.getBookDetails(isbn);
  }
}

final getBookDetailsUseCaseProvider = Provider<GetBookDetailsUseCase>((ref) {
  return GetBookDetailsUseCase(ref.read(booksRepositoryProvider));
});

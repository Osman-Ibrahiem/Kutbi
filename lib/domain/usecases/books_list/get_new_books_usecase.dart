import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/books_repository_impl.dart';
import '../../models/book.dart';
import '../../repositories/books_repository.dart';

class GetNewBooksUseCase {
  final BooksRepository repository;

  GetNewBooksUseCase(this.repository);

  Future<List<Book>> call() {
    return repository.getNewBooks();
  }
}

final getNewBooksUseCaseProvider = Provider<GetNewBooksUseCase>((ref) {
  return GetNewBooksUseCase(ref.read(booksRepositoryProvider));
});

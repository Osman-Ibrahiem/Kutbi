import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/book.dart';
import '../../../domain/usecases/book_details/get_book_details_usecase.dart';

class BookDetailsController extends AsyncNotifier<Book> {
  final String isbn;
  late final GetBookDetailsUseCase getBookDetailsUseCase;

  BookDetailsController(this.isbn);

  @override
  Future<Book> build() async {
    getBookDetailsUseCase = ref.read(getBookDetailsUseCaseProvider);
    return await getBookDetailsUseCase(isbn);
  }
}

final bookDetailsProvider = AsyncNotifierProvider.autoDispose
    .family<BookDetailsController, Book, String>(BookDetailsController.new);

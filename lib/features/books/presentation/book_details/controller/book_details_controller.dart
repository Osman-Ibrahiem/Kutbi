import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/remote/baas/analytics_service.dart';
import '../../../../../core/services/remote/baas/firebase_analytics_service.dart';
import '../../../domain/models/book.dart';
import '../../../domain/usecases/book_details/get_book_details_usecase.dart';

class BookDetailsController extends AsyncNotifier<Book> {
  final String isbn;
  late final GetBookDetailsUseCase getBookDetailsUseCase;
  late final AnalyticsService _analytics;

  BookDetailsController(this.isbn);

  @override
  Future<Book> build() async {
    getBookDetailsUseCase = ref.read(getBookDetailsUseCaseProvider);
    _analytics = ref.read(analyticsServiceProvider);
    final book = await getBookDetailsUseCase(isbn);
    await _logOpenBookDetails(book);
    return book;
  }

  Future<void> _logOpenBookDetails(Book book) async {
    await _analytics.logEvent(
      'view_book_details',
      parameters: {
        'book_id': book.id,
        'book_title': book.title,
        'price': book.price,
      },
    );
  }
}

final bookDetailsProvider = AsyncNotifierProvider.autoDispose
    .family<BookDetailsController, Book, String>(BookDetailsController.new);

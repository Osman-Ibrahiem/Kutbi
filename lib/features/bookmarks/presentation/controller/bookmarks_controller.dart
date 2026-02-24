import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/remote/baas/analytics_service.dart';
import '../../../../core/services/remote/baas/firebase_analytics_service.dart';
import '../../../books/domain/models/book.dart';
import '../../domain/usecases/bookmarks/get_bookmarks_use_case.dart';
import '../../domain/usecases/bookmarks/toggle_bookmark_use_case.dart';

class BookmarksController extends Notifier<List<Book>> {
  late final GetBookmarksUseCase _getBookmarksUseCase;
  late final ToggleBookmarkUseCase _toggleBookmarkUseCase;
  late final AnalyticsService _analytics;

  @override
  List<Book> build() {
    _getBookmarksUseCase = ref.read(getBookmarksUseCaseProvider);
    _toggleBookmarkUseCase = ref.read(toggleBookmarkUseCaseProvider);
    _analytics = ref.read(analyticsServiceProvider);
    return _getBookmarksUseCase();
  }

  Future<void> toggle(Book book) async {
    final isBookmarked = state.any((book) => book.id == book.id);
    await _toggleBookmarkUseCase(book);
    await _logToggleBookmarks(book, isBookmarked);
    state = _getBookmarksUseCase();
  }

  Future<void> _logToggleBookmarks(Book book, bool isBookmarked) async {
    await _analytics.logEvent(
      isBookmarked ? 'remove_from_bookmarks' : 'add_to_bookmarks',
      parameters: {
        'book_id': book.id,
        'book_title': book.title,
        'price': book.price,
      },
    );
  }
}

final bookmarksControllerProvider =
    NotifierProvider<BookmarksController, List<Book>>(BookmarksController.new);

final isBookmarkedProvider = Provider.family<bool, String>((ref, id) {
  final bookmarks = ref.watch(bookmarksControllerProvider);
  return bookmarks.any((book) => book.id == id);
});

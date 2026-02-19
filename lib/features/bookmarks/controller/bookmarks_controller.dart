import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/book.dart';
import '../../../domain/usecases/bookmarks/get_bookmarks_use_case.dart';
import '../../../domain/usecases/bookmarks/toggle_bookmark_use_case.dart';

class BookmarksController extends Notifier<List<Book>> {
  late final GetBookmarksUseCase _getBookmarksUseCase;
  late final ToggleBookmarkUseCase _toggleBookmarkUseCase;

  @override
  List<Book> build() {
    _getBookmarksUseCase = ref.read(getBookmarksUseCaseProvider);
    _toggleBookmarkUseCase = ref.read(toggleBookmarkUseCaseProvider);
    return _getBookmarksUseCase();
  }

  Future<void> toggle(Book book) async {
    await _toggleBookmarkUseCase(book);
    state = _getBookmarksUseCase();
  }
}

final bookmarksControllerProvider =
    NotifierProvider<BookmarksController, List<Book>>(BookmarksController.new);

final isBookmarkedProvider = Provider.family<bool, String>((ref, id) {
  final bookmarks = ref.watch(bookmarksControllerProvider);
  return bookmarks.any((book) => book.id == id);
});

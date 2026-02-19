import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/bookmarks_repository_impl.dart';
import '../../models/book.dart';
import '../../repositories/bookmarks_repository.dart';

class ToggleBookmarkUseCase {
  final BookmarksRepository repository;

  ToggleBookmarkUseCase(this.repository);

  Future<void> call(Book book) async {
    return await repository.toggleBookmark(book);
  }
}

final toggleBookmarkUseCaseProvider = Provider<ToggleBookmarkUseCase>((ref) {
  return ToggleBookmarkUseCase(ref.read(bookmarksRepositoryProvider));
});

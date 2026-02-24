import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../books/domain/models/book.dart';
import '../../../data/repositories/bookmarks_repository_impl.dart';
import '../../repositories/bookmarks_repository.dart';

class GetBookmarksUseCase {
  final BookmarksRepository repository;

  GetBookmarksUseCase(this.repository);

  List<Book> call() {
    return repository.getBookmarks();
  }
}

final getBookmarksUseCaseProvider = Provider<GetBookmarksUseCase>((ref) {
  return GetBookmarksUseCase(ref.read(bookmarksRepositoryProvider));
});

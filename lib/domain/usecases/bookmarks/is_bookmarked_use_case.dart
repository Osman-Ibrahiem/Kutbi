import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/bookmarks_repository_impl.dart';
import '../../repositories/bookmarks_repository.dart';

class IsBookmarkedUseCase {
  final BookmarksRepository repository;

  IsBookmarkedUseCase(this.repository);

  bool call(String id) {
    return repository.isBookmarked(id);
  }
}

final isBookmarkedUseCaseProvider = Provider<IsBookmarkedUseCase>((ref) {
  return IsBookmarkedUseCase(ref.read(bookmarksRepositoryProvider));
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../models/book_model.dart';
import 'local_database.dart';

class HiveService implements LocalDatabase {
  final Box<BookModel> box;

  HiveService(this.box);

  @override
  bool contains(String id) {
    return box.containsKey(id);
  }

  @override
  Future<void> addBook(BookModel bookModel) async {
    final id = bookModel.isbn13;
    if (id == null || id.isEmpty) return;

    if (contains(id)) await deleteBook(id);

    await box.put(bookModel.isbn13, bookModel);
  }

  @override
  Future<void> deleteBook(String id) async {
    if (id.isEmpty) return;
    if (!contains(id)) return;

    await box.delete(id);
  }

  @override
  Future<void> updateBook(String oldId, BookModel bookModel) async {
    final id = bookModel.isbn13;
    if (oldId.isEmpty || id == null || id.isEmpty) return;

    if (contains(oldId)) await deleteBook(oldId);

    addBook(bookModel);
  }

  @override
  Iterable<BookModel> get books => box.values;
}

final bookmarksBoxProvider = Provider<Box<BookModel>>((ref) {
  throw UnimplementedError();
});

final localDatabaseProvider = Provider<LocalDatabase>((ref) {
  return HiveService(ref.read(bookmarksBoxProvider));
});

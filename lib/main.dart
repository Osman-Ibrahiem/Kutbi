import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/books_local_data_source.dart';
import 'data/models/book_hive_adapter.dart';
import 'data/models/book_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final sharedPrefs = await SharedPreferences.getInstance();

  await Hive.initFlutter();
  Hive.registerAdapter(BookHiveAdapter());
  final bookmarksBox = await Hive.openBox<BookModel>('bookmarks_box');

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        bookmarksBoxProvider.overrideWithValue(bookmarksBox),
      ],
      child: const App(),
    ),
  );
}

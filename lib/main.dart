import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/models/book_hive_adapter.dart';
import 'data/models/book_model.dart';
import 'data/services/local/configuration/shared_prefs_service.dart';
import 'data/services/local/database/hive_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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

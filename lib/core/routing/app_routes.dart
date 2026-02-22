import 'package:flutter/material.dart';
import 'package:kutbi/features/book_details/page/book_details_screen.dart';
import 'package:kutbi/features/bookmarks/page/bookmarks_screen.dart';
import 'package:kutbi/features/books_list/page/books_list_screen.dart';
import 'package:kutbi/features/login/page/login_screen.dart';
import 'package:kutbi/features/profile/page/profile_screen.dart';
import 'package:kutbi/features/register/page/register_screen.dart';
import 'package:kutbi/features/settings/page/settings_screen.dart';
import 'package:kutbi/features/splash/page/splash_screen.dart';

class AppRoutes {
  static const initial = splash;

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const booksList = '/books';
  static const bookDetails = '/book-details';
  static const bookmarks = '/bookmarks';
  static const settings = '/settings';
  static const profile = '/profile';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    booksList: (_) => const BooksListScreen(),
    bookDetails: (_) => const BookDetailsScreen(),
    bookmarks: (_) => const BookmarksScreen(),
    settings: (_) => const SettingsScreen(),
    profile: (_) => const ProfileScreen(),
  };
}

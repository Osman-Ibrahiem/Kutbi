import 'package:flutter/material.dart';

import '../../features/auth/presentation/login/page/login_screen.dart';
import '../../features/auth/presentation/register/page/register_screen.dart';
import '../../features/auth/presentation/splash/page/splash_screen.dart';
import '../../features/bookmarks/presentation/page/bookmarks_screen.dart';
import '../../features/books/presentation/book_details/page/book_details_screen.dart';
import '../../features/books/presentation/books_list/page/books_list_screen.dart';
import '../../features/profile/presentation/page/profile_screen.dart';
import '../../features/settings/presentation/page/settings_screen.dart';

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

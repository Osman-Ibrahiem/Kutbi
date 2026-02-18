import 'package:flutter/material.dart';
import 'package:kutbi/features/books_list/page/books_list_screen.dart';
import 'package:kutbi/features/login/page/login_screen.dart';
import 'package:kutbi/features/register/page/register_screen.dart';
import 'package:kutbi/features/splash/presentation/page/splash_screen.dart';

class AppRoutes {
  static const initial = splash;

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const booksList = '/books';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    booksList: (_) => const BooksListScreen(),
  };
}

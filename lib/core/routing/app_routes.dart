import 'package:flutter/material.dart';
import 'package:kutbi/features/splash/presentation/page/splash_screen.dart';

class AppRoutes {
  static const initial = splash;

  static const splash = '/';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
  };
}

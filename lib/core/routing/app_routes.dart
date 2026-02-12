import 'package:flutter/material.dart';

class AppRoutes {
  static const initial = splash;

  static const splash = '/';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const Placeholder(),
  };
}

import 'package:flutter/material.dart';

import 'core/routing/app_routes.dart';

class KutbiApp extends StatelessWidget {
  const KutbiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kutbi',
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/routing/app_routes.dart';

import '../controllers/splash_controller.dart';
import '../state/splash_state.dart';
import '../widgets/splash_screen_body.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SplashState>(
      splashControllerProvider,
      (previous, next) => _handleStateChange(next, context),
    );
    return Scaffold(body: const SplashScreenBody());
  }

  void _handleStateChange(SplashState state, BuildContext context) {
    if (!context.mounted) return;
    if (state is Authenticated) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.booksList);
    } else if (state is Unauthenticated) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }
}

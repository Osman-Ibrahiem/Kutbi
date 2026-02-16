import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/splash_controller.dart';
import '../widgets/splash_screen_body.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(splashControllerProvider.notifier).start());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashScreenBody());
  }
}

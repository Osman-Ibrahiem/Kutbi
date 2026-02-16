import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/splash_controller.dart';
import '../state/splash_effect.dart';
import '../widgets/splash_screen_body.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(splashControllerProvider.notifier).start());

    final controller = ref.read(splashControllerProvider.notifier);

    _sub = controller.effects.listen((effect) {
      if (!mounted) return;
      if (effect is NavigateTo) {
        Navigator.of(context).pushReplacementNamed(effect.route);
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashScreenBody());
  }
}

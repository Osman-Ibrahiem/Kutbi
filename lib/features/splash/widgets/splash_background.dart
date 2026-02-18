import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/theme/app_colors.dart';

import '../controllers/splash_controller.dart';
import '../state/splash_state.dart';

class SplashBackground extends ConsumerWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showGradient = ref.watch(
      splashControllerProvider.select((s) => s is! Solid),
    );

    final colors = showGradient
        ? [AppColors.primary, AppColors.primaryDark]
        : [AppColors.primary, AppColors.primary];

    final decoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      decoration: decoration,
    );
  }
}

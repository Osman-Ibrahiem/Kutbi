import 'package:flutter/material.dart';

import 'splash_background.dart';
import 'splash_logo.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [SplashBackground(), SplashLogo()],
    );
  }
}

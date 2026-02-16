import 'package:flutter/material.dart';
import 'package:kutbi/generated/assets.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(Assets.imagesAppLogo, width: 160, height: 160),
    );
  }
}

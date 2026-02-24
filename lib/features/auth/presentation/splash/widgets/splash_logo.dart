import 'package:flutter/material.dart';

import '../../../../../core/generated/assets.gen.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Assets.images.appLogo.image(width: 160, height: 160));
  }
}

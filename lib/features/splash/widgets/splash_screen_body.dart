import 'package:flutter/material.dart';
import 'package:kutbi/core/theme/app_colors.dart';
import 'package:kutbi/generated/assets.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(color: AppColors.primary),
        Image.asset(
          Assets.imagesAppLogo,
          width: 160,
          height: 160,
        ),
      ],
    );
  }
}

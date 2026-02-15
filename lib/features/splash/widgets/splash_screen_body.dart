import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/theme/app_colors.dart';
import 'package:kutbi/generated/assets.dart';

final isGradientProvider = FutureProvider<bool>((ref) => _isGradient());

Future<bool> _isGradient() async {
  await Future.delayed(const Duration(milliseconds: 1500));
  return true;
}

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [_buildSplashBackground(), _buildSplashLogo()],
    );
  }

  Widget _buildSplashBackground() {
    return Consumer(
      builder: (context, ref, child) {
        final isGradient = ref.watch(isGradientProvider).value == true;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isGradient ? null : AppColors.primary,
            gradient: !isGradient
                ? null
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildSplashLogo() {
    return Image.asset(Assets.imagesAppLogo, width: 160, height: 160);
  }
}

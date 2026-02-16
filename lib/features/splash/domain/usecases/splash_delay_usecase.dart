import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashDelayUseCase {
  Future<void> delayStart() async {
    await Future.delayed(const Duration(milliseconds: 1500));
  }

  Future<void> delaySplash() async {
    await Future.delayed(const Duration(milliseconds: 2500));
  }
}

final splashDelayUseCaseProvider = Provider<SplashDelayUseCase>((ref) {
  return SplashDelayUseCase();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashDelayUseCase {
  Future<void> delay() async {
    await Future.delayed(const Duration(milliseconds: 1500));
  }
}

final splashDelayUseCaseProvider = Provider<SplashDelayUseCase>((ref) {
  return SplashDelayUseCase();
});

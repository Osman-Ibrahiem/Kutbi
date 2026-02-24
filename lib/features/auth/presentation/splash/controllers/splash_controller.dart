import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/splash/is_logged_in_use_case.dart';
import '../state/splash_state.dart';

class SplashController extends Notifier<SplashState> {
  late final IsLoggedInUseCase _usecase;

  @override
  SplashState build() {
    _usecase = ref.read(isLoggedInUseCaseProvider);
    Future.microtask(() => _startSplashSequence());
    return Solid();
  }

  Future<void> _startSplashSequence() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    state = Gradient();

    await Future.delayed(const Duration(milliseconds: 2500));

    final isLoggedIn = _usecase();
    if (isLoggedIn) {
      state = Authenticated();
    } else {
      state = Unauthenticated();
    }
  }
}

final splashControllerProvider =
    NotifierProvider<SplashController, SplashState>(SplashController.new);

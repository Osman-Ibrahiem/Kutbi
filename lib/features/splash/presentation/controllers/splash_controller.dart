import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/splash_delay_usecase.dart';
import '../state/splash_state.dart';
import 'splash_providers.dart';

class SplashController extends Notifier<SplashState> {
  late final SplashDelayUseCase _usecase;

  bool _hasStarted = false;

  @override
  SplashState build() {
    _usecase = ref.read(splashDelayUseCaseProvider);
    return SplashState.initial();
  }

  Future<void> start() async {
    if (_hasStarted) return;
    _hasStarted = true;

    await _usecase.delay();
    state = state.copyWith(showGradient: true);
  }
}

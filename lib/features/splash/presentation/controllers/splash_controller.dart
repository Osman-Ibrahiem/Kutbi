import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/routing/app_routes.dart';

import '../../domain/usecases/splash_delay_usecase.dart';
import '../state/splash_effect.dart';
import '../state/splash_state.dart';

class SplashController extends Notifier<SplashState> {
  late final SplashDelayUseCase _usecase;

  bool _hasStarted = false;

  final _effects = StreamController<SplashEffect>.broadcast();
  Stream<SplashEffect> get effects => _effects.stream;

  @override
  SplashState build() {
    _usecase = ref.read(splashDelayUseCaseProvider);
    ref.onDispose(() => _effects.close());
    return SplashState.initial();
  }

  Future<void> start() async {
    if (_hasStarted) return;
    _hasStarted = true;

    await _usecase.delayStart();
    state = state.copyWith(showGradient: true);

    await _usecase.delaySplash();
    final route = AppRoutes.login;
    _effects.add(NavigateTo(route));
  }
}

final splashControllerProvider =
    NotifierProvider<SplashController, SplashState>(SplashController.new);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/splash_delay_usecase.dart';
import '../state/splash_state.dart';
import 'splash_controller.dart';

final splashDelayUseCaseProvider = Provider<SplashDelayUseCase>((ref) {
  return SplashDelayUseCase();
});

final splashControllerProvider =
    NotifierProvider<SplashController, SplashState>(SplashController.new);

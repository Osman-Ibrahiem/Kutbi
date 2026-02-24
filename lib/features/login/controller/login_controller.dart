import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/api_exception.dart';
import '../../../data/services/remote/baas/analytics_service.dart';
import '../../../data/services/remote/baas/firebase_analytics_service.dart';
import '../../../domain/usecases/login/login_use_case.dart';
import '../state/login_state.dart';

class LoginController extends Notifier<LoginState> {
  late final LoginUseCase _loginUseCase;
  late final AnalyticsService _analytics;

  @override
  LoginState build() {
    _loginUseCase = ref.read(loginUseCaseProvider);
    _analytics = ref.read(analyticsServiceProvider);
    return Initial();
  }

  Future<void> login({required String email, required String password}) async {
    state = Loading();

    try {
      final user = await _loginUseCase(email: email, password: password);
      await _logLoginSuccess(user.id);
      state = Success(user);
    } on ApiException catch (e) {
      state = Failure(e.toString());
    }
  }

  Future<void> _logLoginSuccess(String? userId) async {
    if (userId == null) return;
    await _analytics.setUserId(userId);
    await _analytics.logEvent(
      'login_success',
      parameters: {'method': 'email_password'},
    );
  }

  void reset() => state = Initial();
}

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  LoginController.new,
);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/auth_result.dart';
import '../../data/services/auth_service.dart';
import '../state/login_state.dart';

class LoginController extends Notifier<LoginState> {
  late final AuthService _authService;

  @override
  LoginState build() {
    _authService = ref.read(authServiceProvider);
    return const LoginState();
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: LoginStatus.loading);

    final AuthResult result = await _authService.login(
      email: email,
      password: password,
    );

    if (result.success) {
      state = state.copyWith(status: LoginStatus.success);
    } else {
      state = state.copyWith(
        status: LoginStatus.failure,
        errorMessage: result.errorMessage,
      );
    }
  }

  void reset() => state = const LoginState();
}

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  LoginController.new,
);

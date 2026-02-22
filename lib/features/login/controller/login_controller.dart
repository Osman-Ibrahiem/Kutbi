import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/api_exception.dart';
import '../../../domain/usecases/login/login_use_case.dart';
import '../state/login_state.dart';

class LoginController extends Notifier<LoginState> {
  late final LoginUseCase _loginUseCase;

  @override
  LoginState build() {
    _loginUseCase = ref.read(loginUseCaseProvider);
    return Initial();
  }

  Future<void> login({required String email, required String password}) async {
    state = Loading();

    try {
      final user = await _loginUseCase(email: email, password: password);
      state = Success(user);
    } on ApiException catch (e) {
      state = Failure(e.toString());
    }
  }

  void reset() => state = Initial();
}

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  LoginController.new,
);

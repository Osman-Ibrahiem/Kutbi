import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/api_exception.dart';
import '../../../domain/usecases/register/register_use_case.dart';
import '../state/register_state.dart';

class RegisterController extends Notifier<RegisterState> {
  late final RegisterUseCase _registerUseCase;

  @override
  RegisterState build() {
    _registerUseCase = ref.read(registerUseCaseProvider);
    return Initial();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = Loading();

    try {
      final user = await _registerUseCase(
        name: name,
        email: email,
        password: password,
      );
      state = Success(user);
    } on ApiException catch (e) {
      state = Failure(e.toString());
    }
  }

  void reset() => state = Initial();
}

final registerControllerProvider =
    NotifierProvider<RegisterController, RegisterState>(RegisterController.new);

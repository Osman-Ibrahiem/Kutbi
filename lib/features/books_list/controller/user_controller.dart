import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/user_model.dart';
import '../../../domain/usecases/login/logout_use_case.dart';
import '../../../domain/usecases/splash/get_current_user_use_case.dart';
import '../../../domain/usecases/splash/is_logged_in_use_case.dart';

class UserController extends AsyncNotifier<UserModel> {
  late final GetCurrentUserUseCase getCurrentUserUseCase;
  late final IsLoggedInUseCase isLoggedInUseCase;
  late final LogoutUseCase logoutUseCase;

  UserController();

  @override
  Future<UserModel> build() async {
    getCurrentUserUseCase = ref.read(getCurrentUserUseCaseProvider);
    isLoggedInUseCase = ref.read(isLoggedInUseCaseProvider);
    logoutUseCase = ref.read(logoutUseCaseProvider);

    final user = getCurrentUserUseCase();
    if (user == null) {
      throw Exception('User not logged in');
    }
    return user;
  }

  bool isLoggedIn() {
    return isLoggedInUseCase();
  }

  Future<void> logout() async {
    await logoutUseCase();
  }
}

final userControllerProvider =
    AsyncNotifierProvider.autoDispose<UserController, UserModel>(
      UserController.new,
    );

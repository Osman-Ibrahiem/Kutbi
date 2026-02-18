import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/auth_repository_impl.dart';
import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserModel> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.register(name: name, email: email, password: password);
  }
}

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.read(authRepositoryProvider));
});

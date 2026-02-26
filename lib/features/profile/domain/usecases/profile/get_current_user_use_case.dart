import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../../auth/domain/models/user_model.dart';
import '../../../../auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  UserModel call() {
    return repository.getCurrentUser();
  }
}

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.read(authRepositoryProvider));
});

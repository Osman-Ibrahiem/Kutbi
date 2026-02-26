import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../../auth/domain/models/user_model.dart';
import '../../../../auth/domain/repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<UserModel> call({String? name, String? photoUrl}) {
    return repository.updateProfile(name: name, photoUrl: photoUrl);
  }
}

final updateProfileUseCaseProvider = Provider((ref) {
  return UpdateProfileUseCase(ref.read(authRepositoryProvider));
});

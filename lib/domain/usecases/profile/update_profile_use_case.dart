import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/auth_repository_impl.dart';
import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';

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

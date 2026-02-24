import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/data/repositories/auth_repository_impl.dart';
import '../../../../auth/domain/repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<void> call() {
    return repository.deleteAccount();
  }
}

final deleteAccountUseCaseProvider = Provider((ref) {
  return DeleteAccountUseCase(ref.read(authRepositoryProvider));
});

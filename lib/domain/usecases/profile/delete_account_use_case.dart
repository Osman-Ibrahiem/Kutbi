import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/auth_repository_impl.dart';
import '../../repositories/auth_repository.dart';

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

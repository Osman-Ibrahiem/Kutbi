import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_data_source.dart';
import '../datasources/local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.authDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final user = await authDataSource.login(email: email, password: password);
    await localDataSource.cacheUser(user);
    return user;
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await authDataSource.register(
      name: name,
      email: email,
      password: password,
    );
    return user;
  }

  @override
  Future<bool> isLoggedIn() {
    return localDataSource.isLoggedIn();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return localDataSource.getUser();
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.removeUser();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    authDataSource: ref.read(authDataSourceProvider),
    localDataSource: ref.read(localDataSourceProvider),
  );
});

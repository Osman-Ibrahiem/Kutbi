import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/data/datasources/auth_remote_data_source.dart';

import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final user = await remoteDataSource.login(email: email, password: password);
    await localDataSource.cacheUser(user);
    return user;
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await remoteDataSource.register(
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
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    localDataSource: ref.read(authLocalDataSourceProvider),
  );
});

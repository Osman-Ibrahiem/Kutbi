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
  bool isLoggedIn() {
    return localDataSource.isLoggedIn();
  }

  @override
  UserModel getCurrentUser() {
    final cachedUser = localDataSource.getUser();
    if (cachedUser != null) return cachedUser;

    final user = authDataSource.currentUser;
    if (user == null) throw Exception("No user logged in");
    localDataSource.cacheUser(user);

    return user;
  }

  @override
  Future<UserModel> updateProfile({String? name, String? photoUrl}) async {
    await authDataSource.updateProfile(name: name, photoUrl: photoUrl);

    final currentUser = getCurrentUser();
    final updatedUser = UserModel(
      id: currentUser.id,
      name: name ?? currentUser.name,
      email: currentUser.email,
      token: currentUser.token,
      photoUrl: photoUrl ?? currentUser.photoUrl,
    );

    await localDataSource.cacheUser(updatedUser);
    return updatedUser;
  }

  @override
  Future<void> logout() async {
    await authDataSource.logout();
    await localDataSource.removeUser();
  }

  @override
  Future<void> deleteAccount() async {
    await authDataSource.deleteAccount();
    await localDataSource.removeUser();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    authDataSource: ref.read(authDataSourceProvider),
    localDataSource: ref.read(localDataSourceProvider),
  );
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/user_model.dart';
import '../services/remote/baas/auth_service.dart';
import '../services/remote/baas/firebase_auth_service.dart';

class AuthDataSource {
  final AuthService _service;

  AuthDataSource(this._service);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await _service.signOut();
    return await _service.signIn(email: email, password: password);
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await _service.signOut();
    return await _service.signUp(
      displayName: name,
      email: email,
      password: password,
    );
  }
}

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) => AuthDataSource(ref.read(authServiceProvider)),
);

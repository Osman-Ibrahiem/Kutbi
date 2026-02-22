import '../models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });

  bool isLoggedIn();

  UserModel getCurrentUser();

  Future<UserModel> updateProfile({String? name, String? photoUrl});

  Future<void> logout();

  Future<void> deleteAccount();
}

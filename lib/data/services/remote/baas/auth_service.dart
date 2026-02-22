import '../../../../domain/models/user_model.dart';

abstract class AuthService {
  Future<UserModel> signIn({required String email, required String password});

  Future<UserModel> signUp({
    required String displayName,
    required String email,
    required String password,
  });

  Future<void> signOut();

  Stream<UserModel?> authStateChanges();

  UserModel? get currentUser;

  Future<void> updateProfile({String? name, String? photoUrl});

  Future<void> deleteAccount();
}

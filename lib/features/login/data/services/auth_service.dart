import '../models/auth_result.dart';

abstract class AuthService {
  Future<AuthResult> login({required String email, required String password});
}

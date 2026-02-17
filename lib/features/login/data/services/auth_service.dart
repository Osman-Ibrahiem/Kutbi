import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_result.dart';
import 'firebase_auth_service.dart';

abstract class AuthService {
  Future<AuthResult> login({required String email, required String password});
}

final authServiceProvider = Provider<AuthService>(
  (ref) => FirebaseAuthService(),
);

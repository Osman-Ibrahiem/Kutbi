import 'package:firebase_auth/firebase_auth.dart';
import 'package:kutbi/core/generated/l10n.dart';

import '../models/auth_result.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return AuthResult.success(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(_mapFirebaseError(e.code));
    } catch (_) {
      return AuthResult.failure(S.current.error_unknown);
    }
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'user-not-found':
        return S.current.error_user_not_found;
      case 'wrong-password':
        return S.current.error_wrong_password;
      case 'invalid-email':
        return S.current.error_invalid_email;
      case 'user-disabled':
        return S.current.error_user_disabled;
      case 'too-many-requests':
        return S.current.error_too_many_requests;
      default:
        return S.current.error_login_faild;
    }
  }
}

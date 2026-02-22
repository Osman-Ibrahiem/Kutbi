import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/utils/api_exception.dart';
import 'package:kutbi/core/utils/logger.dart';

import '../../../../domain/models/user_model.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService(this._auth);

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      return _mapFirebaseUserToUserModel(user!);
    } on FirebaseAuthException catch (e) {
      logError('FirebaseAuthException code: ${e.code}');
      throw ApiException(message: _mapFirebaseError(e.code));
    } catch (_) {
      throw ApiException(message: S.current.error_unknown);
    }
  }

  @override
  Future<UserModel> signUp({
    required String displayName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        await user.updateDisplayName(displayName);
        await user.reload();
      }

      return _mapFirebaseUserToUserModel(user!);
    } on FirebaseAuthException catch (e) {
      logError('FirebaseAuthException code: ${e.code}');
      throw ApiException(message: _mapFirebaseError(e.code));
    } catch (_) {
      throw ApiException(message: S.current.error_unknown);
    }
  }

  UserModel _mapFirebaseUserToUserModel(User user) {
    return UserModel(
      id: user.uid,
      email: user.email,
      name: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return _auth.authStateChanges().map((user) {
      return user != null ? _mapFirebaseUserToUserModel(user) : null;
    });
  }

  @override
  Future<UserModel> fetchProfile() async {
    final user = _auth.currentUser;
    return UserModel(
      id: user?.uid,
      name: user?.displayName,
      email: user?.email,
      photoUrl: user?.photoURL,
      token: await user?.getIdToken(),
    );
  }

  @override
  Future<void> updateProfile({String? name, String? photoUrl}) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception("No user logged in");

    if (name != null) await currentUser.updateDisplayName(name);
    if (photoUrl != null) await currentUser.updatePhotoURL(photoUrl);
    await currentUser.reload();
  }

  @override
  Future<void> deleteAccount() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) throw Exception("No user logged in");

    await currentUser.delete();
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
      case 'invalid-credential':
        return S.current.error_invalid_credentials;
      case 'too-many-requests':
        return S.current.error_too_many_requests;
      case 'network-request-failed':
        return S.current.error_no_internet;
      case 'operation-not-allowed':
        return S.current.error_operation_not_allowed;
      case 'email-already-in-use':
        return S.current.error_email_already_used;
      default:
        return S.current.error_unknown;
    }
  }
}

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authServiceProvider = Provider<AuthService>(
  (ref) => FirebaseAuthService(ref.read(firebaseAuthProvider)),
);

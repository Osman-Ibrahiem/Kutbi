import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kutbi/core/generated/l10n.dart';
import 'package:kutbi/core/utils/app_exception.dart';

import '../../domain/models/user_model.dart';
import 'auth_remote_data_source.dart';

class FirebaseAuthDataSource implements AuthRemoteDataSource {
  final FirebaseAuth _auth;

  FirebaseAuthDataSource({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signOut();
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user;
      return UserModel(
        id: user?.uid,
        name: user?.displayName,
        email: user?.email,
        photoUrl: user?.photoURL,
        token: await user?.getIdToken(),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException code: ${e.code}');
      throw AppException(_mapFirebaseError(e.code));
    } catch (_) {
      throw AppException(S.current.error_unknown);
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signOut();
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
      }

      return UserModel(
        id: user?.uid,
        name: user?.displayName,
        email: user?.email,
        photoUrl: user?.photoURL,
        token: await user?.getIdToken(),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException code: ${e.code}');
      throw AppException(_mapFirebaseError(e.code));
    } catch (_) {
      throw AppException(S.current.error_unknown);
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/user_model.dart';
import 'firebase_auth_data_source.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => FirebaseAuthDataSource(auth: ref.read(firebaseAuthProvider)),
);

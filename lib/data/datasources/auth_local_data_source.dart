import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/user_model.dart';
import 'preferences_auth_data_source.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);

  Future<UserModel?> getUser();

  Future<bool> isLoggedIn();

  Future<void> removeUser();
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return PreferencesAuthDataSource(ref.read(sharedPreferencesProvider));
});

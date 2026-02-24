import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/local/configuration/local_configuration.dart';
import '../../../../core/services/local/configuration/shared_prefs_service.dart';
import '../../domain/models/user_model.dart';

class AuthLocalDataSource {
  final LocalConfiguration _localConfiguration;

  AuthLocalDataSource(this._localConfiguration);

  static const String userKey = "user";
  static const String isLoggedInKey = "is_logged_in";

  Future<void> cacheUser(UserModel user) async {
    String userJson = jsonEncode(user.toJson());
    await _localConfiguration.setString(userKey, userJson);
    await _localConfiguration.setBool(isLoggedInKey, true);
  }

  UserModel? getUser() {
    String? userString = _localConfiguration.getString(userKey);

    if (userString != null) {
      return UserModel.fromJson(jsonDecode(userString));
    }
    return null;
  }

  bool isLoggedIn() {
    bool? isLoggedIn = _localConfiguration.getBool(isLoggedInKey);

    if (isLoggedIn != null) {
      return isLoggedIn;
    }
    return false;
  }

  Future<void> removeUser() async {
    await _localConfiguration.remove(userKey);
    await _localConfiguration.remove(isLoggedInKey);
  }
}

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>(
  (ref) => AuthLocalDataSource(ref.read(localConfigurationProvider)),
);

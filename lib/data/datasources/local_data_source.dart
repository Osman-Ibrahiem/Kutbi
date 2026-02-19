import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/user_model.dart';
import '../services/local/configuration/local_configuration.dart';
import '../services/local/configuration/shared_prefs_service.dart';

class LocalDataSource {
  final LocalConfiguration _localConfiguration;

  LocalDataSource(this._localConfiguration);

  static const String userKey = "user";
  static const String isLoggedInKey = "is_logged_in";

  Future<void> cacheUser(UserModel user) async {
    String userJson = jsonEncode(user.toJson());
    await _localConfiguration.setString(userKey, userJson);
    await _localConfiguration.setBool(isLoggedInKey, true);
  }

  Future<UserModel?> getUser() async {
    String? userString = await _localConfiguration.getString(userKey);

    if (userString != null) {
      return UserModel.fromJson(jsonDecode(userString));
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    bool? isLoggedIn = await _localConfiguration.getBool(isLoggedInKey);

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

final localDataSourceProvider = Provider<LocalDataSource>(
  (ref) => LocalDataSource(ref.read(localConfigurationProvider)),
);

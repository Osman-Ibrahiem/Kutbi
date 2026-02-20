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
  static const String themeModeKey = "theme_mode";
  static const String localeKey = "locale";

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

  String? getThemeMode() {
    return _localConfiguration.getString(themeModeKey);
  }

  Future<void> setThemeMode(String? themeMode) async {
    if (themeMode == null || themeMode.isEmpty) {
      await _localConfiguration.remove(themeModeKey);
      return;
    }
    await _localConfiguration.setString(themeModeKey, themeMode);
  }

  String? getLocale() {
    return _localConfiguration.getString(localeKey);
  }

  Future<void> setLocale(String? locale) async {
    if (locale == null || locale.isEmpty) {
      await _localConfiguration.remove(localeKey);
      return;
    }
    await _localConfiguration.setString(localeKey, locale);
  }
}

final localDataSourceProvider = Provider<LocalDataSource>(
  (ref) => LocalDataSource(ref.read(localConfigurationProvider)),
);

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/user_model.dart';
import 'auth_local_data_source.dart';

class PreferencesAuthDataSource implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  PreferencesAuthDataSource(this.sharedPreferences);

  static const String userKey = "user";
  static const String isLoggedInKey = "is_logged_in";

  @override
  Future<void> cacheUser(UserModel user) async {
    String userJson = jsonEncode(user.toJson());
    await sharedPreferences.setString(userKey, userJson);
    await sharedPreferences.setBool(isLoggedInKey, true);
  }

  @override
  Future<UserModel?> getUser() async {
    String? userString = sharedPreferences.getString(userKey);

    if (userString != null) {
      return UserModel.fromJson(jsonDecode(userString));
    }
    return null;
  }

  @override
  Future<bool> isLoggedIn() async {
    bool? isLoggedIn = sharedPreferences.getBool(isLoggedInKey);

    if (isLoggedIn != null) {
      return isLoggedIn;
    }
    return false;
  }

  @override
  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
    await prefs.remove(isLoggedInKey);
  }
}

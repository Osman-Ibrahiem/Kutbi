import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/local/configuration/local_configuration.dart';
import '../../../../core/services/local/configuration/shared_prefs_service.dart';

class SettingsLocalDataSource {
  final LocalConfiguration _localConfiguration;

  SettingsLocalDataSource(this._localConfiguration);

  static const String themeModeKey = "theme_mode";
  static const String localeKey = "locale";

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

final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSource>(
  (ref) => SettingsLocalDataSource(ref.read(localConfigurationProvider)),
);

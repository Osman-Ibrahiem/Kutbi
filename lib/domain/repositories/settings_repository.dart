import '../models/app_locale.dart';
import '../models/app_theme_mode.dart';

abstract class SettingsRepository {
  AppThemeMode getCurrentThemeMode();

  Future<void> setCurrentThemeMode(AppThemeMode theme);

  AppLocale getCurrentLocale();

  Future<void> setCurrentLocale(AppLocale locale);
}

import 'package:flutter/material.dart';

abstract class SettingsRepository {
  ThemeMode getThemeMode();

  Future<void> setThemeMode(ThemeMode themeMode);

  Locale? getLocale();

  Future<void> setLocale(Locale? locale);
}

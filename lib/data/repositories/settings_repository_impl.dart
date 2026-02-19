import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/settings_repository.dart';
import '../datasources/local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final LocalDataSource localDataSource;

  const SettingsRepositoryImpl(this.localDataSource);

  @override
  ThemeMode getThemeMode() {
    final themeMode = localDataSource.getThemeMode();
    if (themeMode == null || themeMode.isEmpty) {
      return ThemeMode.system;
    }
    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    switch (themeMode) {
      case ThemeMode.light:
        await localDataSource.setThemeMode('light');
        break;
      case ThemeMode.dark:
        await localDataSource.setThemeMode('dark');
        break;
      case ThemeMode.system:
        await localDataSource.setThemeMode(null);
        break;
    }
  }

  @override
  Locale? getLocale() {
    final localeString = localDataSource.getLocale();
    if (localeString == null || localeString.isEmpty) {
      return null;
    }
    return Locale(localeString);
  }

  @override
  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      await localDataSource.setLocale(null);
    } else {
      await localDataSource.setLocale(locale.languageCode);
    }
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepositoryImpl(ref.read(localDataSourceProvider)),
);

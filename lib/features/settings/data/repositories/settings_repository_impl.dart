import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasource/settings_local_data_source.dart';
import '../../domain/models/app_locale.dart';
import '../../domain/models/app_theme_mode.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  const SettingsRepositoryImpl(this.localDataSource);

  @override
  AppThemeMode getCurrentThemeMode() {
    final themeMode = localDataSource.getThemeMode();
    return AppThemeMode.fromValue(themeMode);
  }

  @override
  Future<void> setCurrentThemeMode(AppThemeMode theme) async {
    await localDataSource.setThemeMode(theme.toValue());
  }

  @override
  AppLocale getCurrentLocale() {
    final locale = localDataSource.getLocale();
    return AppLocale.fromValue(locale);
  }

  @override
  Future<void> setCurrentLocale(AppLocale locale) async {
    await localDataSource.setLocale(locale.toValue());
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepositoryImpl(ref.read(settingsLocalDataSourceProvider)),
);

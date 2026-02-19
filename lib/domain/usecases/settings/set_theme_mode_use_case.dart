import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/settings_repository_impl.dart';
import '../../repositories/settings_repository.dart';

class SetThemeModeUseCase {
  final SettingsRepository repository;

  SetThemeModeUseCase(this.repository);

  Future<void> call(ThemeMode themeMode) {
    return repository.setThemeMode(themeMode);
  }
}

final setThemeModeUseCaseProvider = Provider<SetThemeModeUseCase>((ref) {
  return SetThemeModeUseCase(ref.read(settingsRepositoryProvider));
});

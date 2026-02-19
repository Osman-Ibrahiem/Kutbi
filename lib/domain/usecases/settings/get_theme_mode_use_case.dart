import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/settings_repository_impl.dart';
import '../../repositories/settings_repository.dart';

class GetThemeModeUseCase {
  final SettingsRepository repository;

  GetThemeModeUseCase(this.repository);

  ThemeMode call() {
    return repository.getThemeMode();
  }
}

final getThemeModeUseCaseProvider = Provider<GetThemeModeUseCase>((ref) {
  return GetThemeModeUseCase(ref.read(settingsRepositoryProvider));
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/settings_repository_impl.dart';
import '../../models/app_theme_mode.dart';
import '../../repositories/settings_repository.dart';

class SetCurrentThemeModeUseCase {
  final SettingsRepository repository;

  SetCurrentThemeModeUseCase(this.repository);

  Future<void> call(AppThemeMode themeMode) {
    return repository.setCurrentThemeMode(themeMode);
  }
}

final setCurrentThemeModeUseCaseProvider = Provider<SetCurrentThemeModeUseCase>(
  (ref) => SetCurrentThemeModeUseCase(ref.read(settingsRepositoryProvider)),
);

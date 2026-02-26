import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/settings_repository_impl.dart';
import '../../models/app_theme_mode.dart';
import '../../repositories/settings_repository.dart';

class GetCurrentThemeModeUseCase {
  final SettingsRepository repository;

  GetCurrentThemeModeUseCase(this.repository);

  AppThemeMode call() {
    return repository.getCurrentThemeMode();
  }
}

final getCurrentThemeModeUseCaseProvider = Provider<GetCurrentThemeModeUseCase>(
  (ref) => GetCurrentThemeModeUseCase(ref.read(settingsRepositoryProvider)),
);

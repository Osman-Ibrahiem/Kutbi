import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/settings_repository_impl.dart';
import '../../models/app_locale.dart';
import '../../repositories/settings_repository.dart';

class SetCurrentLocaleUseCase {
  final SettingsRepository repository;

  SetCurrentLocaleUseCase(this.repository);

  Future<void> call(AppLocale locale) {
    return repository.setCurrentLocale(locale);
  }
}

final setCurrentLocaleUseCaseProvider = Provider<SetCurrentLocaleUseCase>(
  (ref) => SetCurrentLocaleUseCase(ref.read(settingsRepositoryProvider)),
);

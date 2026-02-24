import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/settings_repository_impl.dart';
import '../../models/app_locale.dart';
import '../../repositories/settings_repository.dart';

class GetCurrentLocaleUseCase {
  final SettingsRepository repository;

  GetCurrentLocaleUseCase(this.repository);

  AppLocale call() {
    return repository.getCurrentLocale();
  }
}

final getCurrentLocaleUseCaseProvider = Provider<GetCurrentLocaleUseCase>(
  (ref) => GetCurrentLocaleUseCase(ref.read(settingsRepositoryProvider)),
);

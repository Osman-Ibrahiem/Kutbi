import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/settings_repository_impl.dart';
import '../../repositories/settings_repository.dart';

class SetLocaleUseCase {
  final SettingsRepository repository;

  SetLocaleUseCase(this.repository);

  Future<void> call(Locale? locale) {
    return repository.setLocale(locale);
  }
}

final setLocaleUseCaseProvider = Provider<SetLocaleUseCase>((ref) {
  return SetLocaleUseCase(ref.read(settingsRepositoryProvider));
});

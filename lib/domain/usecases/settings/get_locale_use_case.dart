import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/settings_repository_impl.dart';
import '../../repositories/settings_repository.dart';

class GetLocaleUseCase {
  final SettingsRepository repository;

  GetLocaleUseCase(this.repository);

  Locale? call() {
    return repository.getLocale();
  }
}

final getLocaleUseCaseProvider = Provider<GetLocaleUseCase>((ref) {
  return GetLocaleUseCase(ref.read(settingsRepositoryProvider));
});

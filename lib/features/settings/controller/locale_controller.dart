import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/settings/get_locale_use_case.dart';
import '../../../domain/usecases/settings/set_locale_use_case.dart';

class LocaleController extends Notifier<Locale?> {
  late final GetLocaleUseCase _getLocaleUseCase;
  late final SetLocaleUseCase _setLocaleUseCase;

  @override
  Locale? build() {
    _getLocaleUseCase = ref.read(getLocaleUseCaseProvider);
    _setLocaleUseCase = ref.read(setLocaleUseCaseProvider);
    return _getLocaleUseCase();
  }

  void changeLocale(Locale? locale) {
    _setLocaleUseCase(locale);
    state = _getLocaleUseCase();
  }
}

final localeControllerProvider = NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);

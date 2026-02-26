import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/app_locale.dart';
import '../../domain/usecases/settings/get_current_locale_use_case.dart';
import '../../domain/usecases/settings/set_current_locale_use_case.dart';

class LocaleController extends Notifier<AppLocale> {
  late final GetCurrentLocaleUseCase _getCurrentLocaleUseCase;
  late final SetCurrentLocaleUseCase _setCurrentLocaleUseCase;

  @override
  AppLocale build() {
    _getCurrentLocaleUseCase = ref.read(getCurrentLocaleUseCaseProvider);
    _setCurrentLocaleUseCase = ref.read(setCurrentLocaleUseCaseProvider);
    return _getCurrentLocaleUseCase();
  }

  void changeLocale(AppLocale locale) {
    _setCurrentLocaleUseCase(locale);
    state = _getCurrentLocaleUseCase();
  }

  AppLocale get currentLocale => state;
}

final localeControllerProvider = NotifierProvider<LocaleController, AppLocale>(
  LocaleController.new,
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/settings/get_theme_mode_use_case.dart';
import '../../../domain/usecases/settings/set_theme_mode_use_case.dart';

class ThemeController extends Notifier<ThemeMode> {
  late final GetThemeModeUseCase _getThemeModeUseCase;
  late final SetThemeModeUseCase _setThemeModeUseCase;

  @override
  ThemeMode build() {
    _getThemeModeUseCase = ref.read(getThemeModeUseCaseProvider);
    _setThemeModeUseCase = ref.read(setThemeModeUseCaseProvider);
    return _getThemeModeUseCase();
  }

  void changeTheme(ThemeMode themeMode) {
    _setThemeModeUseCase(themeMode);
    state = _getThemeModeUseCase();
  }
}

final themeControllerProvider = NotifierProvider<ThemeController, ThemeMode>(
  ThemeController.new,
);

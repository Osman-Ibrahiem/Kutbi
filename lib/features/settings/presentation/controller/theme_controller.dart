import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/app_theme_mode.dart';
import '../../domain/usecases/settings/get_current_theme_mode_use_case.dart';
import '../../domain/usecases/settings/set_current_theme_mode_use_case.dart';

class ThemeController extends Notifier<AppThemeMode> {
  late final GetCurrentThemeModeUseCase _getCurrentThemeModeUseCase;
  late final SetCurrentThemeModeUseCase _setCurrentThemeModeUseCase;

  @override
  AppThemeMode build() {
    _getCurrentThemeModeUseCase = ref.read(getCurrentThemeModeUseCaseProvider);
    _setCurrentThemeModeUseCase = ref.read(setCurrentThemeModeUseCaseProvider);
    return _getCurrentThemeModeUseCase();
  }

  void changeTheme(AppThemeMode themeMode) {
    _setCurrentThemeModeUseCase(themeMode);
    state = _getCurrentThemeModeUseCase();
  }

  AppThemeMode get currentThemeMode => state;
}

final themeControllerProvider = NotifierProvider<ThemeController, AppThemeMode>(
  ThemeController.new,
);

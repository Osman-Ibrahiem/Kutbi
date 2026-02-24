import 'package:flutter/material.dart';

enum AppThemeMode {
  light("light"),
  dark("dark"),
  system("system");

  final String value;

  const AppThemeMode(this.value);

  String toValue() => value;

  static AppThemeMode fromValue(String? value) {
    return AppThemeMode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AppThemeMode.system,
    );
  }

  ThemeMode get toThemeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}

import 'package:flutter/material.dart';

enum AppLocale {
  arabic("ar"),
  english("en"),
  system("system");

  final String value;

  const AppLocale(this.value);

  String toValue() => value;

  static AppLocale fromValue(String? value) {
    return AppLocale.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AppLocale.system,
    );
  }

  Locale? get toLocale {
    switch (this) {
      case AppLocale.arabic:
        return Locale(value);
      case AppLocale.english:
        return Locale(value);
      case AppLocale.system:
        return null;
    }
  }
}

import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static const double defaultRadius = 10;

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.lightSurface,
      error: AppColors.lightDestructive,
    );

    return _fromBase(
      colorScheme: scheme,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      inputFillColor: AppColors.lightInput,
      dividerColor: AppColors.lightBorder,
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      surface: AppColors.darkSurface,
      error: AppColors.darkDestructive,
    );

    return _fromBase(
      colorScheme: scheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      inputFillColor: AppColors.darkInput,
      dividerColor: AppColors.darkBorder,
    );
  }

  static ThemeData _fromBase({
    required ColorScheme colorScheme,
    Brightness? brightness,
    Color? scaffoldBackgroundColor,
    Color? inputFillColor,
    Color? dividerColor,
  }) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: AppTextStyles.textTheme(),
      fontFamily: AppTextStyles.displayFont,
    );

    return base.copyWith(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      // ================= TextFormField =================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFillColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),

      // ================= Elevated Button =================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
      ),

      // ================= Text Button =================
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
      ),

      dividerTheme: DividerThemeData(color: dividerColor, thickness: 1),
    );
  }
}

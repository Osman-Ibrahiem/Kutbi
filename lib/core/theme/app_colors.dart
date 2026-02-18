import 'package:flutter/material.dart';

class AppColors {
  // Seed Color (Primary)
  static const primary = Color(0xFFED8C1D);
  static const primaryDark = Color(0xFFCF5417);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color grey = Colors.grey;

  // Light Mode
  static const lightBackground = Color(0xFFF8F5F0);
  static const lightSurface = Color(0xFFF2ECE4);
  static const lightForeground = Color(0xFF2B1E16);
  static const lightBorder = Color(0xFFE5DDD2);
  static const lightAccent = Color(0xFF4B8C73);
  static const lightDestructive = Color(0xFFDC2626);
  static const lightInput = Color(0xFFE6DDD2);

  // Dark Mode
  static const darkBackground = Color(0xFF111418);
  static const darkSurface = Color(0xFF1B1F24);
  static const darkForeground = Color(0xFFE7DED3);
  static const darkBorder = Color(0xFF2A3036);
  static const darkAccent = Color(0xFF4B8C73);
  static const darkDestructive = Color(0xFF7F1D1D);
  static const Color darkInput = Color(0xFF232A33);

  static const Gradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
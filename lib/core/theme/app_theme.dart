import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        background: AppColors.lightBg,
        surface: AppColors.lightSurface,
        onBackground: AppColors.lightTextPrimary,
        onSurface: AppColors.lightTextPrimary,
        error: AppColors.expense,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        background: AppColors.darkBg,
        surface: AppColors.darkSurface,
        onBackground: AppColors.darkTextPrimary,
        onSurface: AppColors.darkTextPrimary,
        error: AppColors.expense,
      ),
    );
  }
}

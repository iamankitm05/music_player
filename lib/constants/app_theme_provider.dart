import 'package:flutter/material.dart';
import 'package:music_player/constants/app_colors.dart';

abstract final class AppThemeProvider {
  static ThemeData generateTheme(Brightness brightness, Color primaryColor) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        primary: primaryColor,
        onPrimary: AppColors.white,
        secondary: AppColors.grey.shade300,
      ),
      popupMenuTheme: PopupMenuThemeData(position: PopupMenuPosition.under),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        surfaceTintColor: primaryColor,
        foregroundColor: AppColors.white,
      ),
      scaffoldBackgroundColor: isDark ? AppColors.black : AppColors.white,
    );
  }
}

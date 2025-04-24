import 'package:flutter/material.dart';
import 'package:music_player/config/theme/app_colors.dart';

abstract final class AppThemes {
  static ThemeData light(Color primaryColor) {
    final lightTheme = ThemeData.light();
    return lightTheme.copyWith(
      primaryColor: primaryColor,
      colorScheme: lightTheme.colorScheme.copyWith(primary: primaryColor),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: AppColors.white,
      ),
    );
  }

  static ThemeData dark(Color primaryColor) {
    final darkTheme = ThemeData.dark();
    return darkTheme.copyWith(
      primaryColor: primaryColor,
      colorScheme: darkTheme.colorScheme.copyWith(primary: primaryColor),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: AppColors.white,
      ),
    );
  }

  static List<Color> get colors => Colors.primaries;
}

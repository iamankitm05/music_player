import 'package:flutter/material.dart';
import 'package:music_player/theme/app_colors.dart';

extension AppThemeExtension on Color {
  ThemeData getThemeData(Brightness brightness) {
    return ThemeData(
      brightness: brightness,
      primaryColor: this,

      appBarTheme: AppBarTheme(
        backgroundColor: this,
        foregroundColor: AppColors.white,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: this,
          foregroundColor: AppColors.white,
          minimumSize: Size(140, 50),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(minimumSize: Size(140, 50)),
      ),
    );
  }
}

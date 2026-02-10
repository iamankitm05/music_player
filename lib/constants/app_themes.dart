import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/constants/app_colors.dart';

abstract final class AppThemes {
  static ThemeData generateTheme(Brightness brightness, Color primaryColor) {
    final isDark = brightness == Brightness.dark;
    final theme = isDark ? ThemeData.dark() : ThemeData.light();
    final poppinsTextTheme = GoogleFonts.poppinsTextTheme(theme.textTheme);

    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        primary: primaryColor,
        onPrimary: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: AppColors.white,
      ),
      scaffoldBackgroundColor: isDark ? AppColors.black : AppColors.white,
      textTheme: poppinsTextTheme,
      primaryTextTheme: poppinsTextTheme,
    );
  }
}

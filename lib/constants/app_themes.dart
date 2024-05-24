import 'package:flutter/material.dart';
import 'package:music_player/constants/app_colors.dart';

abstract final class AppThemes {
  /*
   * Light Theme Data
   */
  static ThemeData lightTheme(Color primary) {
    return ThemeData.light().copyWith(
        primaryColor: primary,
        appBarTheme: getAppBarTheme(primary),
        switchTheme: getSwitchThemeData(primary),
        scaffoldBackgroundColor: AppColors.white,
        elevatedButtonTheme: getElevatedButtonThemeData(primary));
  }

  /*
   * Dark Theme Data
   */
  static ThemeData darkTheme(Color primary) {
    return ThemeData.dark().copyWith(
      primaryColor: primary,
      appBarTheme: getAppBarTheme(primary),
      switchTheme: getSwitchThemeData(primary),
      scaffoldBackgroundColor: AppColors.black,
      elevatedButtonTheme: getElevatedButtonThemeData(primary),
    );
  }

  /*
   * Helper Functions
   */
  static getAppBarTheme(Color primary) => AppBarTheme(
        backgroundColor: primary,
        foregroundColor: AppColors.white,
      );

  static getSwitchThemeData(Color primary) => SwitchThemeData(
        trackColor: WidgetStateProperty.all(primary.withAlpha(150)),
        thumbColor: WidgetStatePropertyAll(primary),
        trackOutlineColor: WidgetStatePropertyAll(primary.withAlpha(150)),
      );

  static ElevatedButtonThemeData getElevatedButtonThemeData(Color primary) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: AppColors.white,
        ),
      );
}

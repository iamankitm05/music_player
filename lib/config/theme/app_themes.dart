import 'package:flutter/material.dart';
import 'package:music_player/config/theme/app_colors.dart';

abstract final class AppThemes {
  static ThemeData get dark {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.dark,
      primaryColor: AppColors.blue,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
      ),
    );
  }
}

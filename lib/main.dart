import 'package:flutter/material.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/constants/app_themes.dart';
import 'package:music_player/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: AppThemes.generateTheme(Brightness.light, AppColors.indigoAccent),
      darkTheme: AppThemes.generateTheme(
        Brightness.dark,
        AppColors.indigoAccent,
      ),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}

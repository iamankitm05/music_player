import 'package:flutter/material.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/constants/app_theme_provider.dart';
import 'package:music_player/screens/home_screen.dart';
import 'package:music_player/utils/di_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DiInjector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: AppThemeProvider.generateTheme(
        Brightness.light,
        AppColors.indigoAccent,
      ),
      darkTheme: AppThemeProvider.generateTheme(
        Brightness.dark,
        AppColors.indigoAccent,
      ),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}

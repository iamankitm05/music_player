import 'package:flutter/material.dart';
import 'package:music_player/config/routes/app_router.dart';
import 'package:music_player/config/theme/app_themes.dart';
import 'package:music_player/core/utils/di_injector.dart';

void main() async {
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '',
      debugShowCheckedModeBanner: false,
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.dark,
      routerConfig: getIt<AppRouter>().router,
    );
  }
}

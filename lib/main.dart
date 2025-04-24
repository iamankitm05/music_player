import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/config/routes/app_router.dart';
import 'package:music_player/config/theme/app_themes.dart';
import 'package:music_player/config/theme/cubit/theme_cubit.dart';
import 'package:music_player/core/utils/di_injector.dart';

void main() async {
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: getIt(),
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Todo List',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.light(state.primaryColor),
          darkTheme: AppThemes.dark(state.primaryColor),
          themeMode: state.themeMode,
          routerConfig: getIt<AppRouter>().router,
        );
      },
    );
  }
}

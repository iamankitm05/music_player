import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/providers/permissions_provider.dart';
import 'package:music_player/screens/home/home_screen.dart';
import 'package:music_player/screens/permissions/permissions_screen.dart';
import 'package:music_player/theme/app_theme_color_provider.dart';
import 'package:music_player/theme/app_theme_extension.dart';
import 'package:music_player/utils/app_strings.dart';
import 'package:music_player/utils/provider_logger.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(ProviderScope(observers: [ProviderLogger()], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeColor = ref.watch(appThemeColorProvider);
    final hasPermission = ref.watch(permissionsProvider).value ?? false;

    return ToastificationWrapper(
      child: MaterialApp(
        title: AppStrings.musicPlayer,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: appThemeColor.getThemeData(Brightness.light),
        darkTheme: appThemeColor.getThemeData(Brightness.dark),
        home: hasPermission ? HomeScreen() : PermissionsScreen(),
      ),
    );
  }
}

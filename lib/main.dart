import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/screens/home/home_screen.dart';
import 'package:music_player/utils/app_strings.dart';
import 'package:music_player/utils/provider_logger.dart';

void main() {
  runApp(ProviderScope(observers: [ProviderLogger()], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppStrings.musicPlayer,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

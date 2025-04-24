import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_player/config/routes/app_router.dart';
import 'package:music_player/config/theme/cubit/theme_cubit.dart';

final getIt = GetIt.I;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton(AppRouter());

  final sharedPreference = await SharedPreferences.getInstance();

  // Register Blocs & Cubits
  getIt.registerSingleton(ThemeCubit.fromSharedPreferences(sharedPreference));
}

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:music_player/config/routes/app_router.dart';

final getIt = GetIt.I;

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton(AppRouter());
}

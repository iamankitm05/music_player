import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player/constants/app_themes.dart';
import 'package:music_player/controllers/app_controller.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/home/home_screen.dart';
import 'package:music_player/screens/permission/permission_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(GetStorage());
  final appController = Get.put(AppController());
  await appController.init();
  final playerController = Get.put(PlayerController());
  await playerController.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appController = Get.find<AppController>();
  final _playerController = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: _appController.appName,
        theme: AppThemes.lightTheme(_appController.primaryColor.value),
        darkTheme: AppThemes.darkTheme(_appController.primaryColor.value),
        themeMode: _appController.getThemeMode(),
        home: _playerController.permissionsStatus.value
            ? HomeScreen()
            : PermissionScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/constants/app_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController {
  final _storage = Get.find<GetStorage>();

  Future<void> init() async {
    final primaryColorCode = _storage.read<int?>(AppConstants.primaryColorKey);
    if (primaryColorCode != null) {
      primaryColor = Color(primaryColorCode).obs;
    } else {
      primaryColor = AppColors.deepPurple.obs;
    }

    final themeStatus = _storage.read<bool?>(AppConstants.isDarkModeKey);
    isDarkMode = RxBool(themeStatus ?? false);

    final packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  late final RxBool isDarkMode;
  late final Rx<Color> primaryColor;
  final homeScreenScaffoldKey = GlobalKey<ScaffoldState>();
  late final String appName;
  late final String version;
  late final String buildNumber;

  void openHomeScreenDrawer() {
    homeScreenScaffoldKey.currentState?.openDrawer();
  }

  void closeHomeScreenDrawer() {
    homeScreenScaffoldKey.currentState?.closeDrawer();
  }

  void setPrimaryColor(Color color) {
    primaryColor.value = color;
    _storage.write(AppConstants.primaryColorKey, color.value);
  }

  ThemeMode getThemeMode() {
    return isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleThemeMode() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
    isDarkMode.value = !isDarkMode.value;
    _storage.write(AppConstants.isDarkModeKey, isDarkMode.value);
  }
}

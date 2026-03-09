import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:music_player/constants/app_typography.dart';
import 'package:music_player/controllers/ad_controller.dart';
import 'package:music_player/controllers/app_controller.dart';
import 'package:music_player/screens/home/widgets/color_picker_dialog.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final _appController = Get.find<AppController>();
  final _adController = Get.find<AdController>();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Settings',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Column(
          children: [
            const Gap(5),
            ListTile(
              title: Text(
                'General',
                style: AppTypography.light15.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Dark Theme',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Obx(
                    () {
                      return Semantics(
                      label: 'Toggle Theme',
                      child: Switch(
                        value: _appController.isDarkMode.value,
                        onChanged: (value) => _appController.toggleThemeMode(),
                        thumbIcon: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return const Icon(Icons.dark_mode);
                          }
                          return const Icon(Icons.light_mode);
                        }),
                      ),
                    );
                    },
                  ),
                ],
              ),
            ),
            const Gap(15),
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Primary Color',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Obx(
                    () {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Semantics(
                          label: 'Select Theme Primary Color',
                          child: GestureDetector(
                            onTap: () => Get.dialog(ColorPickerDialog()),
                            child: FittedBox(
                              child: ColorIndicator(
                                HSVColor.fromColor(_appController.primaryColor.value),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Gap(10),
            Semantics(
              label: 'About App',
              child: AboutListTile(
                applicationName: _appController.appName,
                applicationLegalese:
                    'Version: ${_appController.version}\nBuild Number: ${_appController.buildNumber}\nDeveloped by Ankit kumar',
              ),
            ),
            const Gap(10),
            Semantics(
              label: 'Licenses',
              child: ListTile(
                onTap: () => showLicensePage(
                  context: context,
                ),
                title: const Text('Licenses'),
              ),
            ),
            const Spacer(),
            ListTile(
              title: Text(
                _appController.appName,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                _appController.version,
                textAlign: TextAlign.center,
              ),
              titleAlignment: ListTileTitleAlignment.center,
            )
          ],
        ),
        bottomNavigationBar: Obx(() {
          final settingsScreenBannerAd =
              _adController.settingsScreenBannerAd.value;
          final settingsScreenBannerAdLoaded =
              _adController.settingsScreenBannerAdLoaded.value;
          if (settingsScreenBannerAdLoaded && settingsScreenBannerAd != null) {
            return SizedBox(
              height: 50,
              child: AdWidget(
                ad: settingsScreenBannerAd,
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}

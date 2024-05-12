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
    return Scaffold(
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
          ListTile(
            title: const Text('Dark Theme'),
            trailing: Obx(
              () => SizedBox(
                width: 40,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    value: _appController.isDarkMode.value,
                    onChanged: (value) => _appController.toggleThemeMode(),
                    thumbIcon: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Icon(Icons.dark_mode);
                      }
                      return const Icon(Icons.light_mode);
                    }),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Primary Color'),
            trailing: GestureDetector(
              onTap: () => Get.dialog(ColorPickerDialog()),
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.only(right: 2.5),
                  child: ColorIndicator(
                    HSVColor.fromColor(_appController.primaryColor.value),
                    width: 35,
                    height: 35,
                  ),
                ),
              ),
            ),
          ),
          AboutListTile(
            applicationName: _appController.appName,
            applicationLegalese:
                'Version: ${_appController.version}\nBuild Number: ${_appController.buildNumber}\nDeveloped by Ankit kumar',
          ),
          ListTile(
            onTap: () => showLicensePage(
              context: context,
            ),
            title: const Text('Licenses'),
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
        if (settingsScreenBannerAd != null) {
          return SizedBox(
            height: 50,
            child: AdWidget(
              ad: settingsScreenBannerAd,
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}

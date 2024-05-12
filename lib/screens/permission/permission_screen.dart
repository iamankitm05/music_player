import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/constants/app_typography.dart';
import 'package:music_player/controllers/ad_controller.dart';
import 'package:music_player/controllers/app_controller.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/settings/settings_screen.dart';

class PermissionScreen extends StatelessWidget {
  PermissionScreen({super.key});

  final _appController = Get.find<AppController>();
  final _playerController = Get.find<PlayerController>();
  final _adController = Get.find<AdController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appController.appName),
        titleTextStyle: AppTypography.medium18,
        leading: IconButton(
          onPressed: () {
            Get.to(
              SettingsScreen(),
              transition: Transition.downToUp,
              duration: const Duration(microseconds: 500),
            );
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_appController.appName} uses these permissions',
              textAlign: TextAlign.center,
              style: AppTypography.medium24,
            ),
            const Gap(20),
            Text(
              'Required Permissions',
              style: AppTypography.light13,
            ),
            ListTile(
              leading: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.music_note_outlined,
                  color: AppColors.white,
                ),
              ),
              title: Text(
                'Music and audio',
                style: AppTypography.light15,
              ),
              subtitle: Text(
                'Used to play audio files stored on your phone',
                style: AppTypography.extraLight13,
              ),
            ),
            const Gap(20),
            Text(
              'Features',
              style: AppTypography.light13,
            ),
            ListTile(
              leading: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.rocket_launch,
                  color: AppColors.white,
                ),
              ),
              title: Text(
                'Play your on tracks',
                style: AppTypography.light15,
              ),
              subtitle: Text(
                'Listen to MP3s and other audio files on your phone.',
                style: AppTypography.extraLight13,
              ),
            ),
            const Gap(5),
            ListTile(
              leading: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.color_lens_outlined,
                  color: AppColors.white,
                  size: 28,
                ),
              ),
              title: Text(
                'Theme',
                style: AppTypography.light15,
              ),
              subtitle: Text(
                'Choose your favourite theme.',
                style: AppTypography.extraLight13,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _playerController.permissionsRequest,
                child: const Text('Allow'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        final permissionScreenBannerAd =
            _adController.permissionScreenBannerAd.value;
        if (permissionScreenBannerAd != null) {
          return SizedBox(
            height: 50,
            child: AdWidget(
              ad: permissionScreenBannerAd,
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}

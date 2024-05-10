import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/app_typography.dart';
import 'package:music_player/screens/home/search_screen.dart';
import 'package:music_player/screens/settings/settings_screen.dart';

class HomeScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Music Player'),
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
      actions: [
        IconButton(
          onPressed: () {
            Get.to(
              SearchScreen(),
              transition: Transition.downToUp,
              duration: const Duration(microseconds: 500),
            );
          },
          icon: const Icon(Icons.search),
        ),
        const Gap(5),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

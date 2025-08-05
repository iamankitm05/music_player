import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:music_player/providers/permissions_provider.dart';
import 'package:music_player/theme/app_colors.dart';
import 'package:music_player/utils/app_strings.dart';

class PermissionsScreen extends ConsumerWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionAsyncValue = ref.watch(permissionsProvider);
    final isLoading = permissionAsyncValue.isLoading;

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.musicPlayer)),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              AppStrings.musicPlayerUsesThesePermissions,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),
            const Gap(26),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.requiredPermissions,
                style: textTheme.titleMedium,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.music_note_outlined, color: AppColors.white),
              ),
              title: Text(
                AppStrings.musicAndAudio,
                style: textTheme.bodyMedium,
              ),
              subtitle: Text(
                AppStrings.usedToPlayAudioFilesStoredOnYourPhone,
                style: textTheme.bodySmall,
              ),
            ),
            const Gap(26),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(AppStrings.features, style: textTheme.titleMedium),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.rocket_launch, color: AppColors.white),
              ),
              title: Text(
                AppStrings.playYourOnTracks,
                style: textTheme.bodyMedium,
              ),
              subtitle: Text(
                AppStrings.listenToMP3sAndOtherAudioFilesOnYourPhone,
                style: textTheme.bodySmall,
              ),
            ),
            const Gap(5),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.color_lens_outlined,
                  color: colorScheme.secondary,
                  size: 28,
                ),
              ),
              title: Text(AppStrings.theme, style: textTheme.bodyMedium),
              subtitle: Text(
                AppStrings.chooseYourFavoriteTheme,
                style: textTheme.bodySmall,
              ),
            ),
            const Spacer(),
            OutlinedButton.icon(
              onPressed: () {},
              label: const Text(AppStrings.theme),
              icon: Icon(Icons.color_lens),
            ),
            Gap(10),
            ElevatedButton(
              onPressed: () {
                ref.read(permissionsProvider.notifier).requestPermissions();
              },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(AppStrings.allow),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/constants/app_typography.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/home/widgets/custom_query_artwork_widget.dart';
import 'package:music_player/screens/player/player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SelectedSongTile extends StatelessWidget {
  SelectedSongTile({super.key});

  final _playerController = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final song = _playerController.selectedSong.value;
      if (song == null) {
        return const Gap(0);
      }

      return Semantics(
        label: 'Selected Track',
        child: ListTile(
          onTap: () {
            Get.to(
              PlayerScreen(),
              transition: Transition.downToUp,
              duration: const Duration(microseconds: 500),
            );
          },
          tileColor: Theme.of(context).primaryColor,
          contentPadding: const EdgeInsets.only(
            left: 15,
            right: 5,
          ),
          title: Text(
            song.title,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.extraLight16.copyWith(
              color: AppColors.white,
            ),
          ),
          subtitle: Text(song.artist ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.extraLight13.copyWith(
                color: AppColors.white,
              )),
          leading: CustomQueryArtworkWidget(
            id: song.artistId!,
            artworkType: ArtworkType.ARTIST,
            nullArtworkWidgetBorderColor: AppColors.white,
            nullArtworkWidgetIconColor: AppColors.white,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Semantics(
                label: 'Select Previous',
                child: IconButton(
                  onPressed: _playerController.selectPreviousSong,
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    color: AppColors.white,
                  ),
                ),
              ),
              StreamBuilder(
                stream: _playerController.getPlayerStateStream(),
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final isPlaying = playerState?.playing ?? false;
                  if (isPlaying) {
                    return Semantics(
                      label: 'Pause',
                      child: IconButton(
                        onPressed: _playerController.pause,
                        icon: const Icon(
                          Icons.pause_rounded,
                          color: AppColors.white,
                        ),
                      ),
                    );
                  }
                  return Semantics(
                    label: 'Play',
                    child: IconButton(
                      onPressed: _playerController.play,
                      icon: const Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.white,
                      ),
                    ),
                  );
                },
              ),
              Semantics(
                label: 'Select Next',
                child: IconButton(
                  onPressed: _playerController.selectNextSong,
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

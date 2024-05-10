import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/constants/app_typography.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/home/widgets/custom_query_artwork_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  PlayerScreen({super.key});

  final _playerController = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Current Track',
          style: AppTypography.medium18,
        ),
      ),
      body: Obx(() {
        final selectedSong = _playerController.selectedSong.value!;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(35),
          child: Column(
            children: [
              CustomQueryArtworkWidget(
                artworkWidth: 200,
                artworkHeight: 200,
                nullArtworkWidgetIconSize: 50,
                artworkBorder: BorderRadius.circular(20),
                id: selectedSong.artistId!,
                artworkType: ArtworkType.ARTIST,
              ),
              const Gap(25),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  selectedSong.title,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: AppTypography.light18,
                ),
              ),
              const Gap(5),
              Text(
                selectedSong.artist ?? 'Unknown',
                textAlign: TextAlign.center,
                style: AppTypography.extraLight13,
              ),
              const Spacer(),
              LoadingAnimationWidget.beat(
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              const Spacer(),
              ProgressBar(
                progress: const Duration(milliseconds: 1000),
                buffered: const Duration(milliseconds: 2000),
                total: const Duration(milliseconds: 5000),
                onSeek: (duration) {},
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _playerController.setShuffleing,
                    icon: Obx(() {
                      final shuffleingOn = _playerController.shuffleingOn.value;
                      return Icon(
                        Icons.shuffle,
                        color: shuffleingOn ? AppColors.white : AppColors.grey,
                        size: shuffleingOn ? 22 : 18,
                      );
                    }),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      color: AppColors.white,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: AppColors.white,
                    ),
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      color: AppColors.white,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: _playerController.setPlayMode,
                    icon: Obx(() {
                      final playMode = _playerController.playMode.value;
                      if (playMode == PlayMode.repeat) {
                        return const Icon(
                          Icons.repeat,
                          color: AppColors.white,
                          size: 22,
                        );
                      } else if (playMode == PlayMode.single) {
                        return const Icon(
                          Icons.repeat_one,
                          color: AppColors.white,
                          size: 22,
                        );
                      } else {
                        return const Icon(
                          Icons.repeat,
                          color: AppColors.grey,
                          size: 18,
                        );
                      }
                    }),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.amber,
      ),
    );
  }
}

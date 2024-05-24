import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/constants/app_typography.dart';
import 'package:music_player/controllers/ad_controller.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/home/widgets/custom_query_artwork_widget.dart';
import 'package:music_player/screens/player/widgets/play_pause_button.dart';
import 'package:music_player/screens/player/widgets/repeat_mode_button.dart';
import 'package:music_player/screens/player/widgets/shuffle_button.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  PlayerScreen({super.key});

  final _playerController = Get.find<PlayerController>();
  final _adController = Get.find<AdController>();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Current Track',
      child: Scaffold(
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
                StreamBuilder(
                    stream: _playerController.getPlayerStateStream(),
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final isPlaying = playerState?.playing ?? false;
                      if (isPlaying) {
                        return LoadingAnimationWidget.beat(
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        );
                      } else {
                        return const Gap(0);
                      }
                    }),
                const Spacer(),
                StreamBuilder(
                    stream: _playerController.getPlayerPositionDataStream(),
                    builder: (context, snapshot) {
                      final playerPositionData = snapshot.data;
                      final position =
                          playerPositionData?.position ?? Duration.zero;
                      final bufferedPosition =
                          playerPositionData?.bufferedPosition ?? Duration.zero;
                      final duration =
                          playerPositionData?.duration ?? Duration.zero;
                      return ProgressBar(
                        progress: position,
                        buffered: bufferedPosition,
                        total: duration,
                        onSeek: _playerController.seek,
                      );
                    }),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      final shuffleingOn = _playerController.shuffleingOn.value;
                      return ShuffleButton(
                        isEnable: shuffleingOn,
                        onPressed: _playerController.setShuffleing,
                      );
                    }),
                    Semantics(
                      label: 'Select Previous',
                      child: IconButton(
                        onPressed: _playerController.selectPreviousSong,
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          size: 40,
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: _playerController.getPlayerStateStream(),
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final isPlaying = playerState?.playing ?? false;
                        if (isPlaying) {
                          return PlayPauseButton(
                            label: 'Pause',
                            iconData: Icons.pause_rounded,
                            onPressed: _playerController.pause,
                          );
                        }

                        return PlayPauseButton(
                          label: 'Play',
                          iconData: Icons.play_arrow_rounded,
                          onPressed: _playerController.play,
                        );
                      },
                    ),
                    Semantics(
                      label: 'Select Next',
                      child: IconButton(
                        onPressed: _playerController.selectNextSong,
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          size: 40,
                        ),
                      ),
                    ),
                    Obx(() {
                      final playMode = _playerController.playMode.value;
                      if (playMode == PlayMode.repeat) {
                        return RepeatModeButton(
                          playMode: playMode,
                          onPressed: _playerController.setPlayMode,
                          size: 22,
                          iconData: Icons.repeat,
                          label: 'Repeat',
                        );
                      } else if (playMode == PlayMode.single) {
                        return RepeatModeButton(
                          playMode: playMode,
                          onPressed: _playerController.setPlayMode,
                          size: 22,
                          iconData: Icons.repeat_one,
                          label: 'Repeat Once',
                        );
                      } else {
                        return RepeatModeButton(
                          playMode: playMode,
                          onPressed: _playerController.setPlayMode,
                          size: 18,
                          iconData: Icons.repeat_one,
                          label: 'No Repeat',
                          color: AppColors.grey,
                        );
                      }
                    }),
                  ],
                ),
              ],
            ),
          );
        }),
        bottomNavigationBar: Obx(() {
          final playerScreenBannerAd = _adController.playerScreenBannerAd.value;
          final playerScreenBannerAdLoaded =
              _adController.playerScreenBannerAdLoaded.value;
          if (playerScreenBannerAdLoaded && playerScreenBannerAd != null) {
            return SizedBox(
              height: 50,
              child: AdWidget(
                ad: playerScreenBannerAd,
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}

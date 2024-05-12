import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/home/widgets/custom_query_artwork_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SongTile extends StatelessWidget {
  SongTile({
    super.key,
    required this.song,
  });

  final SongModel song;

  final _playerController = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSongSelected =
          song.id == _playerController.selectedSong.value?.id;
      return ListTile(
        onTap: () {
          _playerController.selectSong(song);
          _playerController.play();
        },
        selected: isSongSelected,
        title: Text(
          song.title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          song.artist ?? 'Unknown',
          overflow: TextOverflow.ellipsis,
        ),
        leading: CustomQueryArtworkWidget(
          id: song.artistId!,
          artworkType: ArtworkType.ARTIST,
        ),
        trailing: StreamBuilder(
            stream: _playerController.getPlayerStateStream(),
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final isPlaying = playerState?.playing ?? false;
              if (isPlaying && isSongSelected) {
                return LoadingAnimationWidget.beat(
                  size: 16,
                  color: Theme.of(context).primaryColor,
                );
              }
              return const Gap(0);
            }),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/home/widgets/custom_query_artwork_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatelessWidget {
  SongTile({
    super.key,
    required this.song,
  });

  final SongModel song;

  final playerController = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListTile(
        onTap: () => playerController.selectSong(song),
        selected: song.id == playerController.selectedSong.value?.id,
        contentPadding: const EdgeInsets.only(
          left: 15,
          right: 5,
        ),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAnimationWidget.beat(
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              constraints: const BoxConstraints(minWidth: 150),
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(child: Text('Delete')),
              ],
            ),
          ],
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
            StreamBuilder(
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
            PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              constraints: const BoxConstraints(minWidth: 150),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  onTap: () async {
                    final wantToDelete = await Get.dialog<bool?>(AlertDialog(
                      title: const Text('Delete'),
                      content: Text(
                          '${song.title} will be Permanently deleted from your storage'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Get.back(result: true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ));

                    if (wantToDelete ?? false) {
                      _playerController.deleteSong(song);
                      print("::::::::: Deleted :::::::::::::::::");
                    }
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

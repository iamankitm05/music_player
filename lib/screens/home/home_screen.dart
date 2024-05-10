import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/controllers/app_controller.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/home/widgets/home_screen_appbar.dart';
import 'package:music_player/screens/home/widgets/selected_song_tile.dart';
import 'package:music_player/screens/home/widgets/song_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final appController = Get.find<AppController>();
  final playerController = Get.find<PlayerController>()..getSongs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeScreenAppbar(),
      body: Obx(
        () {
          if (playerController.isSongsLoading.value) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                size: 36,
                color: Theme.of(context).primaryColor,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: playerController.getSongs,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: playerController.songs.length,
                    itemBuilder: (context, index) =>
                        SongTile(song: playerController.songs[index]),
                  ),
                ),
                SelectedSongTile(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.amber,
      ),
    );
  }
}

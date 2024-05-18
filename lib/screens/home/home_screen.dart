import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player/controllers/ad_controller.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/home/widgets/home_screen_appbar.dart';
import 'package:music_player/screens/home/widgets/selected_song_tile.dart';
import 'package:music_player/screens/home/widgets/song_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _playerController = Get.find<PlayerController>();
  final _adController = Get.find<AdController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeScreenAppbar(),
      body: Obx(
        () {
          if (_playerController.isSongsLoading.value) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                size: 36,
                color: Theme.of(context).primaryColor,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _playerController.getSongs,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _playerController.songs.length,
                    itemBuilder: (context, index) =>
                        SongTile(song: _playerController.songs[index]),
                  ),
                ),
                SelectedSongTile(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Obx(() {
        final homeScreenBannerAd = _adController.homeScreenBannerAd.value;
        final homeScreenBannerAdLoaded =
            _adController.homeScreenBannerAdLoaded.value;
        if (homeScreenBannerAdLoaded && homeScreenBannerAd != null) {
          return SizedBox(
            height: 50,
            child: AdWidget(
              ad: homeScreenBannerAd,
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}

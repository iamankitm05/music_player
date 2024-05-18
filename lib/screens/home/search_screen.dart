import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/constants/app_typography.dart';
import 'package:music_player/controllers/ad_controller.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/home/widgets/selected_song_tile.dart';
import 'package:music_player/screens/home/widgets/song_tile.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final _searchController = TextEditingController();
  final _playerController = Get.find<PlayerController>()..clearFilteredSongs();
  final _adController = Get.find<AdController>();

  @override
  Widget build(BuildContext context) {
    const border = UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.white,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _playerController.search,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          style: AppTypography.extraLight16.copyWith(
            color: AppColors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: AppTypography.light15.copyWith(
              color: AppColors.white.withOpacity(0.5),
            ),
            border: border,
            focusedBorder: border,
            enabledBorder: border,
            suffixIcon: IconButton(
              onPressed: () {
                _searchController.clear();
                _playerController.clearFilteredSongs();
              },
              icon: const Icon(
                Icons.clear,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: _playerController.filteredSongs.length,
                itemBuilder: (context, index) {
                  return SongTile(song: _playerController.filteredSongs[index]);
                },
              );
            }),
          ),
          SelectedSongTile(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        final searchScreenBannerAd = _adController.searchScreenBannerAd.value;
        final searchScreenBannerAdLoaded =
            _adController.searchScreenBannerAdLoaded.value;
        if (searchScreenBannerAdLoaded && searchScreenBannerAd != null) {
          return SizedBox(
            height: 50,
            child: AdWidget(
              ad: searchScreenBannerAd,
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}

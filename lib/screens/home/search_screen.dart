import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/constants/app_typography.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/home/widgets/song_tile.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchController = TextEditingController();
  final playerController = Get.find<PlayerController>()..clearFilteredSongs();

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
          controller: searchController,
          onChanged: playerController.search,
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
                searchController.clear();
                playerController.clearFilteredSongs();
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
                itemCount: playerController.filteredSongs.length,
                itemBuilder: (context, index) {
                  return SongTile(song: playerController.filteredSongs[index]);
                },
              );
            }),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.amber,
      ),
    );
  }
}

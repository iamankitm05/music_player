import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/screens/home/albums_tab_view.dart';
import 'package:music_player/screens/home/all_songs_tab_view.dart';
import 'package:music_player/screens/home/artists_tab_view.dart';
import 'package:music_player/screens/home/playlist_tab_view.dart';
import 'package:music_player/screens/search/search_screen.dart';
import 'package:music_player/theme/app_colors.dart';
import 'package:music_player/utils/app_strings.dart';
import 'package:music_player/widgets/color_plate_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.musicPlayer),
        actions: [
          IconButton(
            onPressed: () {
              SearchScreen.navigate(context);
            },
            icon: Icon(Icons.search),
          ),
          PopupMenuButton(itemBuilder: _itemBuilder),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            ColoredBox(
              color: primaryColor,
              child: TabBar(
                labelColor: AppColors.white,
                tabs: [
                  Tab(text: AppStrings.all),
                  Tab(text: AppStrings.artists),
                  Tab(text: AppStrings.albums),
                  Tab(text: AppStrings.playlist),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                children: [
                  AllSongsTabView(),
                  ArtistsTabView(),
                  AlbumsTabView(),
                  PlaylistTabView(),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 16),
            tileColor: primaryColor,
            leading: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.music_note),
            ),
            title: Text('Song #1'),
            subtitle: Text('Unknown'),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.pause)),
          ),
          Container(color: Colors.amber, width: double.infinity, height: 50),
        ],
      ),
    );
  }

  List<PopupMenuEntry> _itemBuilder(BuildContext context) {
    return [
      PopupMenuItem(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ColorPlateDialog(),
          );
        },
        child: Text(AppStrings.theme),
      ),
      PopupMenuItem(
        onTap: () {
          showAboutDialog(context: context);
        },
        child: Text(AppStrings.aboutApp),
      ),
      // PopupMenuItem(onTap: () {}, child: Text(AppStrings.privacyPolicy)),
    ];
  }
}

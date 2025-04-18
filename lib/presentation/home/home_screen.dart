import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/config/routes/app_routes.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/core/constants/app_images.dart';
import 'package:music_player/presentation/home/music_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(AppImages.iconPng),
                    radius: 20,
                  ),
                  Gap(8),
                  Expanded(child: Text('Music Player')),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.pushNamed(AppRoutes.settings.name);
                  },
                  icon: Icon(Icons.settings),
                ),
                Gap(6),
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                color: AppColors.blue,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search your favorite song.',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.white),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.white),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            PinnedHeaderSliver(
              child: Container(
                color: AppColors.blue,
                child: SafeArea(
                  child: TabBar(
                    tabs: [
                      Tab(text: 'Songs'),
                      Tab(text: 'Artist'),
                      Tab(text: 'Folder'),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                  childAspectRatio: 4 / 1,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                ),
                itemBuilder: (context, index) {
                  return MusicTile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

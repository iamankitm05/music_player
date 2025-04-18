import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/core/constants/app_images.dart';

class MusicTile extends StatelessWidget {
  const MusicTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkSurface,
      child: Row(
        children: [
          Image.asset(AppImages.iconPng),
          Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Song',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Gap(4),
                Text('03:43', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              //...
            },
            icon: Icon(Icons.play_arrow),
          ),
          Gap(6),
        ],
      ),
    );
  }
}

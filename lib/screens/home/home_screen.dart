import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/config/routes/app_routes.dart';
import 'package:music_player/core/constants/app_images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(AppImages.iconPng)),
            Gap(12),
            Expanded(child: Text('ToDo List')),
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
    );
  }
}

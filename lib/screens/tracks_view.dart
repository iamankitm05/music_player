import 'package:flutter/material.dart';
import 'package:music_player/widgets/track_tile.dart';

class TracksView extends StatefulWidget {
  const TracksView({super.key});

  @override
  State<TracksView> createState() => __TracksViewState();
}

class __TracksViewState extends State<TracksView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        itemBuilder: (context, index) {
          return TrackTile();
        },
      ),
    );
  }
}

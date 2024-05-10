import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomQueryArtworkWidget extends StatelessWidget {
  const CustomQueryArtworkWidget({
    super.key,
    required this.id,
    required this.artworkType,
    this.artworkWidth = 50,
    this.artworkHeight = 50,
    this.artworkBorder,
    this.nullArtworkWidgetColor,
    this.nullArtworkWidgetIconColor,
    this.nullArtworkWidgetIconSize = 24,
    this.nullArtworkWidgetBorderColor,
  });

  final int id;
  final ArtworkType artworkType;
  final double artworkWidth;
  final double artworkHeight;
  final BorderRadius? artworkBorder;
  final Color? nullArtworkWidgetColor;
  final Color? nullArtworkWidgetBorderColor;
  final Color? nullArtworkWidgetIconColor;
  final double nullArtworkWidgetIconSize;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: id,
      type: artworkType,
      artworkWidth: artworkWidth,
      artworkHeight: artworkHeight,
      artworkBorder: artworkBorder ?? BorderRadius.circular(50),
      nullArtworkWidget: Container(
        width: artworkWidth,
        height: artworkHeight,
        decoration: BoxDecoration(
          color: nullArtworkWidgetColor,
          border: Border.all(
            color:
                nullArtworkWidgetBorderColor ?? Theme.of(context).primaryColor,
          ),
          borderRadius: artworkBorder ?? BorderRadius.circular(50),
        ),
        child: Icon(
          Icons.music_note_outlined,
          color: nullArtworkWidgetIconColor,
          size: nullArtworkWidgetIconSize,
        ),
      ),
    );
  }
}

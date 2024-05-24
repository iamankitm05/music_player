import 'package:flutter/material.dart';
import 'package:music_player/constants/app_colors.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    super.key,
    required this.iconData,
    this.onPressed,
    this.label,
  });

  final IconData iconData;
  final String? label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: AppColors.white,
        ),
        icon: Icon(
          iconData,
          size: 40,
        ),
      ),
    );
  }
}

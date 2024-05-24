import 'package:flutter/material.dart';
import 'package:music_player/controllers/player_controller.dart';

class RepeatModeButton extends StatelessWidget {
  const RepeatModeButton({
    super.key,
    required this.playMode,
    required this.onPressed,
    required this.size,
    this.color,
    required this.iconData,
    required this.label,
  });

  final IconData iconData;
  final PlayMode playMode;
  final VoidCallback onPressed;
  final double size;
  final Color? color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          size: size,
          color: color,
        ),
      ),
    );
  }
}

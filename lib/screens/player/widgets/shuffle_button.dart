import 'package:flutter/material.dart';
import 'package:music_player/constants/app_colors.dart';

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({
    super.key,
    required this.isEnable,
    required this.onPressed,
  });

  final bool isEnable;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: isEnable ? 'Shuffling Enable' : 'Shuffling Disable',
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.shuffle,
          size: isEnable ? 22 : 18,
          color: isEnable ? null : AppColors.grey,
        ),
      ),
    );
  }
}

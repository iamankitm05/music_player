import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/widgets/custom_elevated_button.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key, required this.onPermissionTap});

  final VoidCallback onPermissionTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Spacer(flex: 5),
        Container(
          width: 500,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(26),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          margin: EdgeInsets.all(24),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_outlined,
                size: 48,
                color: AppColors.amber,
              ),
              Gap(16),
              Text('Permission Required', style: textTheme.headlineSmall),
              Gap(8),
              Text(
                'Please grant storage permission to access your music files.',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Gap(16),
              CustomElevatedButton(
                onPressed: onPermissionTap,
                title: 'Grant Permission',
              ),
            ],
          ),
        ),
        Spacer(flex: 7),
      ],
    );
  }
}

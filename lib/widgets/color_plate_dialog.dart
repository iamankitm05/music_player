import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/theme/app_colors.dart';
import 'package:music_player/theme/app_theme_color_provider.dart';
import 'package:music_player/utils/app_strings.dart';

class ColorPlateDialog extends ConsumerWidget {
  const ColorPlateDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeColor = ref.watch(appThemeColorProvider);
    final colors = AppColors.colors;
    final screenSize = MediaQuery.sizeOf(context);

    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      title: Text(AppStrings.selectThemeColor),
      content: SizedBox(
        width: 500,
        height: screenSize.height * 0.5,
        child: GridView.builder(
          itemCount: colors.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final color = colors[index];
            return GestureDetector(
              onTap: () {
                ref
                    .read(appThemeColorProvider.notifier)
                    .changeThemeColor(color);
              },
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                child: appThemeColor == color
                    ? Icon(Icons.check, color: AppColors.white, size: 32)
                    : null,
              ),
            );
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppStrings.cancel),
        ),
      ],
    );
  }
}

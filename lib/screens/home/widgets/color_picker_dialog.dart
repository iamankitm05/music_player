import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:music_player/constants/app_colors.dart';
import 'package:music_player/constants/app_typography.dart';
import 'package:music_player/controllers/app_controller.dart';

class ColorPickerDialog extends StatelessWidget {
  ColorPickerDialog({super.key});

  final _appController = Get.find<AppController>()..closeHomeScreenDrawer();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Primary Color',
        style: AppTypography.medium18,
      ),
      content: SizedBox(
        height: 300,
        child: BlockPicker(
          pickerColor: _appController.primaryColor.value,
          onColorChanged: _appController.setPrimaryColor,
          itemBuilder: (color, isCurrentColor, changeColor) => Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: changeColor,
                child: ColorIndicator(
                  HSVColor.fromColor(color),
                  width: 40,
                  height: 40,
                ),
              ),
              if (isCurrentColor)
                const Icon(
                  Icons.check,
                  color: AppColors.white,
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: const Text('Close'),
        ),
      ],
    );
  }
}

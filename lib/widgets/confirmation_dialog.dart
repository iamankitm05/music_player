import 'package:flutter/material.dart';
import 'package:music_player/theme/app_colors.dart';
import 'package:music_player/utils/app_strings.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.onConfirm,
    this.onCancel,
    this.okBtnLabel = 'Ok',
    this.okBtnColor,
  });

  final String title;
  final String message;
  final String okBtnLabel;
  final Color? okBtnColor;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      title: Text(title),
      content: SizedBox(width: 500, child: Text(message)),
      actions: [
        TextButton(
          onPressed: () {
            if (onCancel != null) onCancel!();
            Navigator.pop(context);
          },
          child: Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (onConfirm != null) onConfirm!();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: okBtnColor,
            foregroundColor: AppColors.white,
          ),
          child: Text(okBtnLabel),
        ),
      ],
    );
  }
}

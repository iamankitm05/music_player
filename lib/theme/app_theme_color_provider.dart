import 'package:flutter/widgets.dart';
import 'package:music_player/theme/app_colors.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_color_provider.g.dart';

@Riverpod(keepAlive: true)
class AppThemeColor extends _$AppThemeColor {
  @override
  Color build() {
    return AppColors.deepPurple;
  }

  void changeThemeColor(Color color) {
    state = color;
  }
}

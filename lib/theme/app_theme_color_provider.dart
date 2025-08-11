import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:music_player/providers/shared_preference_provider.dart';
import 'package:music_player/theme/app_colors.dart';
import 'package:music_player/utils/shared_preference_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_color_provider.g.dart';

@Riverpod(keepAlive: true)
class AppThemeColor extends _$AppThemeColor {
  @override
  Color build() {
    final sharedPreference = ref.watch(sharedPreferenceProvider);
    final themeColorData = sharedPreference.getInt(
      SharedPreferenceKeys.themeColor,
    );
    final themeColor = themeColorData != null
        ? Color(themeColorData)
        : AppColors.deepPurple;

    return themeColor;
  }

  void changeThemeColor(Color color) {
    final sharedPreference = ref.read(sharedPreferenceProvider);
    unawaited(
      sharedPreference.setInt(
        SharedPreferenceKeys.themeColor,
        color.toARGB32(),
      ),
    );
    state = color;
  }
}

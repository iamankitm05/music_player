import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/core/constants/shared_Preference_keys.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(super.initialState, this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  static ThemeCubit fromSharedPreferences(SharedPreferences sharedPreferences) {
    final themeModeIndex =
        sharedPreferences.getInt(SharedPreferenceKeys.primaryThemeMode) ?? 0;
    final themeMode = ThemeMode.values[themeModeIndex];

    final themePrimaryColorData =
        sharedPreferences.getInt(SharedPreferenceKeys.primaryThemeColor) ??
        AppColors.indigo.toARGB32();
    final themePrimaryColor = Color(themePrimaryColorData);

    return ThemeCubit(
      ThemeState.fromThemeMode(themeMode, themePrimaryColor),
      sharedPreferences,
    );
  }

  void changeThemeMode(ThemeMode themeMode) {
    unawaited(
      sharedPreferences.setInt(
        SharedPreferenceKeys.primaryThemeMode,
        themeMode.index,
      ),
    );
    emit(ThemeState.fromThemeMode(themeMode, state.primaryColor));
  }

  void changeThemeColor(Color themeColor) {
    unawaited(
      sharedPreferences.setInt(
        SharedPreferenceKeys.primaryThemeColor,
        themeColor.toARGB32(),
      ),
    );
    emit(ThemeState.fromThemeMode(state.themeMode, themeColor));
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:music_player/config/theme/app_colors.dart';
import 'package:music_player/config/theme/app_themes.dart';
import 'package:music_player/config/theme/cubit/theme_cubit.dart';
import 'package:music_player/core/utils/di_injector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColors = AppThemes.colors;
    final themeCubit = getIt<ThemeCubit>();
    final selectedThemePrimaryColor = themeCubit.state.primaryColor;
    final selectedThemeMode = themeCubit.state.themeMode;
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      //..
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Theme',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ToggleButtons(
                        onPressed: (index) {
                          themeCubit.changeThemeMode(ThemeMode.values[index]);
                        },
                        isSelected: [
                          selectedThemeMode == ThemeMode.system,
                          selectedThemeMode == ThemeMode.light,
                          selectedThemeMode == ThemeMode.dark,
                        ],
                        children: [
                          Tooltip(
                            message: 'Auto',
                            child: Icon(Icons.brightness_auto),
                          ),
                          Tooltip(
                            message: 'Light',
                            child: Icon(Icons.wb_sunny),
                          ),
                          Tooltip(
                            message: 'Dark',
                            child: Icon(Icons.dark_mode),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(50),
                  Text(
                    'Primary Color',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Gap(20),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 50,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: themeColors.length,
              itemBuilder: (context, index) {
                final color = themeColors[index];
                return InkWell(
                  onTap: () {
                    themeCubit.changeThemeColor(color);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child:
                        selectedThemePrimaryColor == color
                            ? Icon(
                              Icons.check,
                              color: AppColors.white,
                              size: 32,
                            )
                            : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

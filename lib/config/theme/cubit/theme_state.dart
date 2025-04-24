part of 'theme_cubit.dart';

sealed class ThemeState extends Equatable {
  const ThemeState(this.primaryColor, this.themeMode);

  final Color primaryColor;
  final ThemeMode themeMode;

  factory ThemeState.fromThemeMode(ThemeMode themeMode, Color primaryColor) {
    if (themeMode == ThemeMode.light) return LightTheme(primaryColor);
    if (themeMode == ThemeMode.dark) return DarkTheme(primaryColor);
    return SystemTheme(primaryColor);
  }

  @override
  List<Object> get props => [primaryColor, themeMode];
}

final class SystemTheme extends ThemeState {
  const SystemTheme(Color primaryColor) : super(primaryColor, ThemeMode.system);
}

final class LightTheme extends ThemeState {
  const LightTheme(Color primaryColor) : super(primaryColor, ThemeMode.light);
}

final class DarkTheme extends ThemeState {
  const DarkTheme(Color primaryColor) : super(primaryColor, ThemeMode.dark);
}

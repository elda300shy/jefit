import 'package:flutter/material.dart';
import 'package:jefit/config/theme/colors/dark_theme_colors.dart';

/// generate a dark theme

class DarkThemeManager {
  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: DarkThemeColors.primaryColor,
        scaffoldBackgroundColor: DarkThemeColors.scaffoldBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: DarkThemeColors.appBarColor,
        ),
        colorScheme:const  ColorScheme(
          brightness: Brightness.dark,
          primary: DarkThemeColors.primaryColor,
          onPrimary: DarkThemeColors.onPrimaryColor,
          secondary: DarkThemeColors.secondaryColor,
          onSecondary: DarkThemeColors.onSecondaryColor,
          error: DarkThemeColors.errorColor,
          onError: DarkThemeColors.onErrorColor,
          surface: DarkThemeColors.surfaceColor,
          onSurface: DarkThemeColors.onSurfaceColor,
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:location_box/app/product/theme/custom_color_schemes.dart';
import 'package:location_box/app/product/theme/custom_theme.dart';

final class CustomDarkTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
      useMaterial3: true,
      colorScheme: CustomColorSchemes.darkColorScheme,
      floatingActionButtonTheme: floatingActionButtonThemeData);

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData();
}

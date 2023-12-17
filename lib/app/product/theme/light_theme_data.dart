import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_box/app/product/theme/custom_color_schemes.dart';
import 'package:location_box/app/product/theme/custom_theme.dart';

final class CustomLightTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: CustomColorSchemes.lightColorScheme,
        floatingActionButtonTheme: floatingActionButtonThemeData,
        fontFamily: GoogleFonts.roboto().fontFamily,
      );

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      FloatingActionButtonThemeData();
}

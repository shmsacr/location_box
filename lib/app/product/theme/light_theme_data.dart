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
        inputDecorationTheme: inputDecorationTheme,
      );

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      FloatingActionButtonThemeData();
      
        @override
        // TODO: implement inputDecorationTheme
        InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: CustomColorSchemes.lightColorScheme.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          errorStyle: TextStyle(
            color: Colors.red,
          ),
        );
}

import 'package:flutter/material.dart';
import 'package:location_box/app/product/theme/custom_color_schemes.dart';
import 'package:location_box/app/product/theme/custom_theme.dart';

final class CustomDarkTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
      useMaterial3: true,
      colorScheme: CustomColorSchemes.darkColorScheme,
      floatingActionButtonTheme: floatingActionButtonThemeData,
      inputDecorationTheme: inputDecorationTheme,
      );

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData();

  @override
  // TODO: implement inputDecorationTheme
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        border: OutlineInputBorder(),
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
            color: Colors.red,
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

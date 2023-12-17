import 'package:flutter/material.dart';

final class CustomColorSchemes {
  CustomColorSchemes._();

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF705D00),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFE16F),
    onPrimaryContainer: Color(0xFF221B00),
    secondary: Color(0xFF675E40),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFEFE2BC),
    onSecondaryContainer: Color(0xFF211B04),
    tertiary: Color(0xFF44664D),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFC6ECCD),
    onTertiaryContainer: Color(0xFF00210E),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF1D1B16),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF1D1B16),
    surfaceVariant: Color(0xFFEAE2CF),
    onSurfaceVariant: Color(0xFF4B4639),
    outline: Color(0xFF7C7767),
    onInverseSurface: Color(0xFFF6F0E7),
    inverseSurface: Color(0xFF33302A),
    inversePrimary: Color(0xFFE3C54A),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF705D00),
    outlineVariant: Color(0xFFCDC6B4),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFE3C54A),
    onPrimary: Color(0xFF3A3000),
    primaryContainer: Color(0xFF544600),
    onPrimaryContainer: Color(0xFFFFE16F),
    secondary: Color(0xFFD2C6A1),
    onSecondary: Color(0xFF373016),
    secondaryContainer: Color(0xFF4E462A),
    onSecondaryContainer: Color(0xFFEFE2BC),
    tertiary: Color(0xFFAAD0B1),
    onTertiary: Color(0xFF163722),
    tertiaryContainer: Color(0xFF2D4E37),
    onTertiaryContainer: Color(0xFFC6ECCD),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1D1B16),
    onBackground: Color(0xFFE8E2D9),
    surface: Color(0xFF1D1B16),
    onSurface: Color(0xFFE8E2D9),
    surfaceVariant: Color(0xFF4B4639),
    onSurfaceVariant: Color(0xFFCDC6B4),
    outline: Color(0xFF979080),
    onInverseSurface: Color(0xFF1D1B16),
    inverseSurface: Color(0xFFE8E2D9),
    inversePrimary: Color(0xFF705D00),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFE3C54A),
    outlineVariant: Color(0xFF4B4639),
    scrim: Color(0xFF000000),
  );
}
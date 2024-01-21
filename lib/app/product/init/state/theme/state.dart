import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class AppThemeState extends Equatable {
  final ThemeMode themeMode;
  final bool isDarkMode;

  AppThemeState({required this.themeMode,this.isDarkMode = false});

  @override
  List<Object?> get props => [themeMode];

  AppThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return AppThemeState(
      themeMode: themeMode ?? this.themeMode,
      isDarkMode: themeMode == ThemeMode.dark ? true : false,
    );
  }
}

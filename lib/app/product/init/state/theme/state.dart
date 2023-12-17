import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class AppThemeState extends Equatable {
  final ThemeMode themeMode;

  AppThemeState({this.themeMode = ThemeMode.dark});

  @override
  List<Object?> get props => [themeMode];

  AppThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return AppThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

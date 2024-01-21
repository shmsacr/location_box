import 'package:flutter/material.dart';
import 'package:location_box/app/core/service/app_state_service/app_state_service_impl.dart';
import 'package:location_box/app/product/init/state/base/base_cubit.dart';
import 'package:location_box/app/product/init/state/theme/state.dart';

final class AppThemeViewModel extends BaseCubit<AppThemeState> {
  AppThemeViewModel() : super(AppThemeState(themeMode: ThemeMode.light));

  final appStateService = AppStateServiceImplement();
  Future<void> setThemeMode({required bool themeMode}) async {
    await appStateService.setThemeMode(themeMode: themeMode);
    emit(state.copyWith(
        themeMode: themeMode ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> getThemeMode() async {
    bool themeMode = await appStateService.getThemeMode();
    emit(state.copyWith(
        themeMode: themeMode ? ThemeMode.dark : ThemeMode.light));
  }
}

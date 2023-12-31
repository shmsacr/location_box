import 'package:flutter/material.dart';
import 'package:location_box/app/product/init/state/base/base_cubit.dart';
import 'package:location_box/app/product/init/state/theme/state.dart';

final class AppThemeViewModel extends BaseCubit<AppThemeState>{
  AppThemeViewModel() : super(AppThemeState());

  void changeThemeMode() {
    state.themeMode == ThemeMode.dark
        ? emit(state.copyWith(themeMode: ThemeMode.light))
        : emit(state.copyWith(themeMode: ThemeMode.dark));
  }
}

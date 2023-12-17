import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_box/app/product/init/localization/app_localization.dart';
import 'package:location_box/app/product/init/state/theme/view_model.dart';
import 'package:location_box/app/product/init/state_initialize.dart';
import 'package:location_box/app/product/navigation/app_router.dart';
import 'package:location_box/app/product/theme/dark_theme_data.dart';
import 'package:location_box/app/product/theme/light_theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(AppLocalization(child: StateInitialize(child: _MyApp())));
}

final class _MyApp extends StatelessWidget {
  static final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: CustomLightTheme().themeData,
      themeMode: context.watch<AppThemeViewModel>().state.themeMode,
      darkTheme: CustomDarkTheme().themeData,
      title: 'Material App',
    );
  }
}

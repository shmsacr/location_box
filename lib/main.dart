import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location_box/app/product/init/localization/app_localization.dart';
import 'package:location_box/app/product/init/state/theme/view_model.dart';
import 'package:location_box/app/product/init/state_initialize.dart';
import 'package:location_box/app/product/model/app_state/app_state.dart';
import 'package:location_box/app/product/model/location/location_model.dart';
import 'package:location_box/app/product/model/my_view_model.dart';
import 'package:location_box/app/product/navigation/app_router.dart';
import 'package:location_box/app/product/theme/dark_theme_data.dart';
import 'package:location_box/app/product/theme/light_theme_data.dart';


Future<void> main() async {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<MyViewModel>(MyViewModel(), signalsReady: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<LocationModel>(LocationModelAdapter());
  Hive.registerAdapter<AppState>(AppStateAdapter());
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

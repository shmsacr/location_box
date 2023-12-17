import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:location_box/app/product/init/custom_localization.dart';
import 'package:location_box/app/product/theme/dark_theme_data.dart';
import 'package:location_box/app/product/theme/light_theme_data.dart';
import 'package:location_box/app/view/home/view/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(CustomLocalization(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: ThemeMode.light,
      theme: CustomLightTheme().themeData,
      darkTheme: CustomDarkTheme().themeData,
      title: 'Material App',
      home: HomeView(),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_box/app/product/init/localization/app_localization.dart';
import 'package:location_box/app/product/init/state/theme/view_model.dart';
import 'package:location_box/app/product/utility/constants/enum/locales.dart';

import '../../../product/init/localization/locale_keys.g.dart';

@RoutePage()
final class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppThemeViewModel(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => AppLocalization.updateLanguage(
              locales: Locales.tr, context: context),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
            title: Text('Material App Bar'),
            leading: IconButton(
              onPressed: context.read<AppThemeViewModel>().changeThemeMode,
              icon: const Icon(Icons.add),
            )),
        body: Center(
          child: Card(
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              child: Text(LocaleKeys.general_button_ok).tr(),
            ),
          ),
        ),
      ),
    );
  }
}

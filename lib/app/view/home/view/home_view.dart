import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:location_box/app/product/init/custom_localization.dart';
import 'package:location_box/app/product/utility/constants/enum/locales.dart';
import 'package:location_box/product/init/language/locale_keys.g.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomLocalization.updateLanguage(
              locales: Locales.en, context: context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Card(
          child: Container(
            width: 200,
            height: 200,
            child: Text(LocaleKeys.general_button_ok).tr(),
          ),
        ),
      ),
    );
  }
}

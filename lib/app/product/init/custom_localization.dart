import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:location_box/app/product/utility/constants/enum/locales.dart';

/// localization manager
final class CustomLocalization extends EasyLocalization {
  /// The `CustomLocalization` class is a subclass of `EasyLocalization` class. The constructor of
  /// `CustomLocalization` class is calling the constructor of its superclass `EasyLocalization` using the
  CustomLocalization({
    required super.child,
    super.key,
  }) : super(
          supportedLocales: _supportedLocales,
          path: _translationAssetPath,
          useOnlyLangCode: true,
        );

  /// The `static final List<Locale> _supportedLocales` is a list of supported locales in the
  static final List<Locale> _supportedLocales = <Locale>[
    Locales.en.locale,
    Locales.tr.locale,
  ];

  static const String _translationAssetPath = 'assets/translations';

  /// The function updates the language of the app based on the provided locales and context.

  static Future<void> updateLanguage(
          {required Locales locales, required BuildContext context}) =>
      context.setLocale(locales.locale);
}

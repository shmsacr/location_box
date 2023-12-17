import 'package:flutter/material.dart';

/// The code snippet is defining an enumeration called `Locales` that represents different language
enum Locales {
  en(locale: Locale('en', 'US')),
  tr(locale: Locale('tr', 'TR'));

  final Locale locale;

  const Locales({required this.locale});

  /// The code snippet is defining a static method called `values`
  ///  that returns a list of all the values in the enumeration.
  static final List<Locale> supportedLocales = <Locale>[
    Locales.en.locale,
    Locales.tr.locale,
  ];
}

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

extension MediaQueryExtension on BuildContext {
  double get zeroValue => 0;
  double get constLowValue => 8;
  double get constNormalValue => 16;
  double get constMediumValue => 32;
  double get constHighValue => 48;

  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;

  double get lowValue => height * 0.008;
  double get normalValue => height * 0.016;
  double get mediumValue => height * 0.032;
  double get highValue => height * 0.1;
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension SizedBoxExtension on BuildContext {
  Widget get emptySizedWidthBoxLow => const SizedBox(width: 0.01);

  Widget get emptySizedHeightBoxLow => const SizedBox(height: 0.01);
}

extension RadiusExtension on BuildContext {
  Radius get lowRadius => Radius.circular(width * 0.02);
  Radius get normalRadius => Radius.circular(width * 0.05);
  Radius get highRadius => Radius.circular(width * 0.1);
}

extension SizedBoxNum on BuildContext {
  SizedBox get sizedHeightBoxLow => SizedBox(height: constLowValue);
  SizedBox get sizedHeightBoxNormal => SizedBox(height: constNormalValue);
  SizedBox get sizedHeightBoxMedium => const SizedBox(height: 24);
  SizedBox get sizedHeightBoxHigh => const SizedBox(height: 32);

  SizedBox get sizedWidthBoxLow => const SizedBox(width: 8);
  SizedBox get sizedWidthBoxNormal => const SizedBox(width: 16);
  SizedBox get sizedWidthBoxMedium => const SizedBox(width: 24);
  SizedBox get sizedWidthBoxHigh => const SizedBox(width: 32);
}

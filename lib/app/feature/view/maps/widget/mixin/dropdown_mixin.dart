import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/feature/view/maps/enum/markes_icon_enum.dart';
import 'package:location_box/app/feature/view/maps/widget/dropdown_widget.dart';

mixin CustomDropDownWidgetMixin on State<CustomDropDownWidget>{
  final ValueNotifier<MarkerIcons> _selectedIcon =
      ValueNotifier<MarkerIcons>(MarkerIcons.ic_default);

   ValueNotifier<MarkerIcons> get selectedIcon => _selectedIcon;

@override
  void initState() {
    super.initState();
    // Set the initial value based on iconPath
    if (widget.iconPath == null) {
      _selectedIcon.value = MarkerIcons.ic_default;
    } else {
      // If iconPath is not null, find the corresponding MarkerIcon
      final icon = MarkerIcons.values.firstWhere(
        (markerIcon) => markerIcon.value == widget.iconPath,
        orElse: () => MarkerIcons.ic_default,
      );
      _selectedIcon.value = icon;
    }
  }
}
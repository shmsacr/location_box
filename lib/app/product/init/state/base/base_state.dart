import 'package:flutter/material.dart';
import 'package:location_box/app/product/init/state/app/prod_state_get_it.dart';
import 'package:location_box/app/product/init/state/theme/view_model.dart';
import 'package:location_box/app/feature/view/maps/view_model/google_maps_view_model.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  AppThemeViewModel get appThemeViewModel =>
      ProductStateGetIt.appThemeViewModel;

}

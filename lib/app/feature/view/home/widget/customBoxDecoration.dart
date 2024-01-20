import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_box/app/product/init/state/theme/view_model.dart';

class CustomBoxDecoration {
  static BoxDecoration getBoxDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: context.watch<AppThemeViewModel>().state.isDarkMode
            ? [
                Colors.blueGrey,
                Colors.black,
              ]
            : [
                Colors.white,
                Color(0xff90dbe5),
              ],
      ),
    );
  }
}

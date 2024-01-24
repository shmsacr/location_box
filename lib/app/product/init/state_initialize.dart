import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_box/app/feature/view/home/view_model/home_view_model.dart';
import 'package:location_box/app/feature/view/maps/view_model/google_maps_view_model.dart';
import 'package:location_box/app/product/init/state/theme/view_model.dart';

final class StateInitialize extends StatelessWidget {
  const StateInitialize({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppThemeViewModel>.value(
          value: AppThemeViewModel()..getThemeMode(),
        ),
        BlocProvider<GoogleMapsViewModel>.value(
          value: GoogleMapsViewModel()..getLocations(),
        ),
        BlocProvider<HomeViewModel>.value(
            value: HomeViewModel()..getLocations()),
      ],
      child: child,
    );
  }
}

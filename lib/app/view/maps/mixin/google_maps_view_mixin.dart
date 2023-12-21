import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/view/maps/view/google_maps_view.dart';
import 'package:location_box/app/view/maps/view_model/google_maps_view_model.dart';

mixin GoogleMapsViewMixin on State<GoogleMapsView> {
  late GoogleMapController mapController;
  final formKey = GlobalKey<FormBuilderState>();
  final mapsViewModel = GoogleMapsViewModel();

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();
    super.dispose();
  }

  Future<void> getLocation() async {
    await mapsViewModel.getCurrentLocation();
    print(
        'State : ${mapsViewModel.state.latitude}, ${mapsViewModel.state.longitude},${mapsViewModel.state.currentLocation}}');
  }

  Set<Marker> createMarker() {
    return {
      Marker(
        markerId: MarkerId("current_location"),
        position: mapsViewModel.state.currentLocation!,
        infoWindow: InfoWindow(title: "Your Current Location"),
      ),
    };
  }
}

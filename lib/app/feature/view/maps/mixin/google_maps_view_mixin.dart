import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/feature/view/maps/view/google_maps_view.dart';
import 'package:location_box/app/feature/view/maps/view_model/google_maps_view_model.dart';

mixin GoogleMapsViewMixin on State<GoogleMapsView> {
  late final GoogleMapsViewModel _googleMapsViewModel;
  GoogleMapsViewModel get googleMapsViewModel => _googleMapsViewModel;

  @override
  void initState() {
    _googleMapsViewModel = context.read<GoogleMapsViewModel>();
    super.initState();
    getLocationMaps();
  }

  @override
  void dispose() {
    googleMapsViewModel.mapController.dispose();
    googleMapsViewModel.formKey.currentState?.reset();
    googleMapsViewModel.formKey.currentState?.dispose();
    googleMapsViewModel.addressController.dispose();
    googleMapsViewModel.descriptionController.dispose();
    googleMapsViewModel.imageController.dispose();
    googleMapsViewModel.titleController.dispose();
    super.dispose();
  }

  Future<void> getLocationMaps() async {
    await context.read<GoogleMapsViewModel>().getCurrentLocation();
  }

  Set<Marker> createMarker({required LatLng position}) {
    return {
      Marker(
        markerId: MarkerId("current_location"),
        position: position,
        infoWindow: InfoWindow(title: "Your Current Location"),
      ),
    };
  }
}

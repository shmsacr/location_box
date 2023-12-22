import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/view/maps/view/google_maps_view.dart';
import 'package:location_box/app/view/maps/view_model/google_maps_view_model.dart';

mixin GoogleMapsViewMixin on State<GoogleMapsView> {
  final googleMapsViewModel = GoogleMapsViewModel();
  @override
  void initState() {
    super.initState();
    getLocationMaps();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<GoogleMapsViewModel>().getLocations();
  }

  @override
  void dispose() {
    googleMapsViewModel.formKey.currentState?.reset();
    googleMapsViewModel.formKey.currentState?.dispose();
    
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/view/maps/view/google_maps_view.dart';
import 'package:location_box/app/view/maps/view_model/google_maps_view_model.dart';

mixin GoogleMapsViewMixin on State<GoogleMapsView> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  late GoogleMapController mapController;
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    getLocationMaps();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();
    addressController.dispose();

    descriptionController.dispose();
    imageController.dispose();
    titleController.dispose();

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

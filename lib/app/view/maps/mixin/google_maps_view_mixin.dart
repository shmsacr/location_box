
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/view/maps/google_maps_view.dart';

mixin GoogleMapsViewMixin on State<GoogleMapsView>{
late GoogleMapController mapController;
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
          print('currentLocation: $currentLocation');
        });
      }
    } catch (e) {
      print('Error getting current location: $e');
    }
  }
  
   Set<Marker> createMarker() {
    return {
      Marker(
        markerId: MarkerId("current_location"),
        position: currentLocation!,
        infoWindow: InfoWindow(title: "Your Current Location"),
      ),
    };
  }
}
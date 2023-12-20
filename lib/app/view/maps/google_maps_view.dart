import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/view/maps/mixin/google_maps_view_mixin.dart';

class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({super.key});

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView>
    with GoogleMapsViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: () {
            showModalBottomSheet(context: 
            , builder: (context) => );
          } ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: currentLocation == null
            ? const CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 14.4746,
              )
            : CameraPosition(
                target: currentLocation!,
                zoom: 14.4746,
              ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: currentLocation != null ? createMarker() : {},
      ),
    );
  }
}

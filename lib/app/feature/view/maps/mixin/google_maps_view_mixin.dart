import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/feature/view/home/view_model/home_view_model.dart';
import 'package:location_box/app/feature/view/maps/view/google_maps_view.dart';
import 'package:location_box/app/product/model/location/location_model.dart';

mixin GoogleMapsViewMixin on State<GoogleMapsView> {
  late final HomeViewModel _googleMapsViewModel;
  HomeViewModel get googleMapsViewModel => _googleMapsViewModel;
  File? imageFile;
  List<Marker> markers = [];
  late final CustomInfoWindowController customInfoWindowController;

  @override
  void initState() {
    _googleMapsViewModel = context.read<HomeViewModel>();
    customInfoWindowController = CustomInfoWindowController();
    initMarker();
    super.initState();
  }

  @override
  void dispose() {
    customInfoWindowController.dispose();
    super.dispose();
  }

  Future<void> initMarker() async {
    await multipleMarker(_googleMapsViewModel.state.locations);
    setState(() {});
  }

  Future<List<Marker>> multipleMarker(
      List<LocationModel>? locationState) async {
    if (locationState != null) {
      for (var position in locationState) {
        final icon = await _createMarkerImageFromAsset(position.iconPath!);
        markers.add(
          Marker(
            icon: icon,
            markerId: MarkerId(position.id!),
            onTap: () {
              if (customInfoWindowController.addInfoWindow != null) {
                customInfoWindowController.addInfoWindow!(
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.blue,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                position.picture == null
                                    ? Icon(
                                        Icons.image,
                                        size: 50,
                                      )
                                    : Image.file(
                                        File(position.picture ?? ''),
                                        width: 50,
                                        height: 50,
                                      ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Column(children: [
                                  Text(
                                    position.title ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    position.description ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  LatLng(position.latitude!, position.longitude!),
                );
              }
            },
            position: LatLng(position.latitude!, position.longitude!),
          ),
        );
      }
    }
    return markers;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    final file = File(path);
    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      ui.Codec codec = await ui.instantiateImageCodec(bytes,
          targetWidth: width); // Adjust width as needed
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();
    } else {
      throw Exception('File not found: $path');
    }
  }

  Future<BitmapDescriptor> _createMarkerImageFromAsset(String iconPath) async {
    final icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 5.5), iconPath);
    return icon;
  }
}

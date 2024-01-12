import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location_box/app/feature/view/maps/view/google_maps_view.dart';
import 'package:location_box/app/feature/view/maps/view_model/google_maps_view_model.dart';
import 'package:location_box/app/feature/view/maps/widget/custom_info_windows.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

mixin GoogleMapsViewMixin on State<GoogleMapsView> {
  late final GoogleMapsViewModel _googleMapsViewModel;
  GoogleMapsViewModel get googleMapsViewModel => _googleMapsViewModel;
  File? imageFile;

  @override
  void initState() {
    _googleMapsViewModel = context.read<GoogleMapsViewModel>();
    super.initState();
    getLocationMaps();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getLocationMaps() async {
    await context.read<GoogleMapsViewModel>().getCurrentLocation();
  }

  Future<void> pickPhoto() async {
    if (await _requestGalleryPermission()) {
      XFile? getFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (getFile != null) {
        setState(() {
          imageFile = File(getFile.path);
        });
      }
    }
    return null;
  }

  Future<void> takePhoto() async {
    if (await _requestCameraPermission()) {
      XFile? getFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (getFile != null) {
        String dir = path.dirname(getFile.path);
        final String pathName = DateFormat("Hms-m-ms-s").format(DateTime.now());
        String newPath = path.join(dir, "location_box_${pathName}.jpg");
        await getFile.saveTo(newPath);

        setState(() {
          imageFile = File(getFile.path);
        });
      }
    }
    return null;
  }

  Future<bool> _requestGalleryPermission() async {
    var status = await Permission.storage.status;
    print(status);
    if (status.isGranted) {
      return true;
    } else {
      var result = await Permission.storage.request();
      return result.isGranted;
    }
  }

  Future<bool> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    print(status);
    if (status.isGranted) {
      return true;
    } else {
      var result = await Permission.camera.request();
      return result.isGranted;
    }
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

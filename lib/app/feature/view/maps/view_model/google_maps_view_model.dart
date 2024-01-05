import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/core/service/location_service/location_service_impl.dart';
import 'package:location_box/app/core/service/location_storage/location_storage_impl.dart';
import 'package:location_box/app/feature/view/maps/view_model/state/google_maps_state.dart';
import 'package:location_box/app/product/model/location/location_model.dart';
import 'package:location_box/gen/src/asset/assets.gen.dart';
import 'package:uuid/uuid.dart';

final class GoogleMapsViewModel extends Cubit<GoogleMapsState> {
  GoogleMapsViewModel() : super(GoogleMapsState());
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  GoogleMapController? _mapController;
  final TextEditingController _titleController = TextEditingController();
    final TextEditingController _iconController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  TextEditingController get addressController => _addressController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get imageController => _imageController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get titleController => _titleController;
  TextEditingController get iconController => _iconController;
  GlobalKey<FormBuilderState> get formKey => _formKey;
  GoogleMapController? get mapController => _mapController;

  GoogleMapController? setMapController(GoogleMapController controller) {
    _mapController = controller;
    return _mapController;
  }

  final LocationStorageImpl _locationStorage = LocationStorageImpl();

  Future<void> saveLocation(File? imagePath) async {
    try {
      print('_formKey.currentState: ${_formKey.currentState}');
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        DateTime now = DateTime.now();
        final String? _id = Uuid().v4();
        emit(state.copyWith(
          latitude: state.latitude! + 0.11,
        ));
        print('ID : $_id');
        final LocationModel _location = LocationModel.fromJson(
          {
            'id': _id,
            'title': _formKey.currentState!.value['title'],
            'address': _formKey.currentState!.value['address'],
            'description': _formKey.currentState!.value['description'],
            'picture': imagePath?.path,
            'phone': _formKey.currentState!.value['phone'],
            'latitude': state.latitude,
            'longitude': state.longitude,
            'createdAt': now.toString(),
          },
        );
        final response =
            await _locationStorage.addLocation(location: _location);
        emit(state.copyWith(
          isSaving: false,
        ));
        if (response) {
          emit(state.copyWith(
            isSaving: true,
            locations: state.locations == null
                ? [_location]
                : [...state.locations!, _location],
          ));
        }
      }
      print('_formKey.currentState: ${_formKey.currentState}');
      print('State : ${state.locations}');
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
      ));
      throw ('Error saving location: $e');
    }
  }

  Future<void> getLocations() async {
    getCurrentLocation();
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final response = await _locationStorage.getAllLocations();
      final markers = await multipleMarker(response);
      emit(state.copyWith(
          locations: response.isNotEmpty ? response : null,
          isLoading: false,
          markers: markers));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
      ));
      throw ('Error getting locations: $e');
    }
  }

  Future<void> deleteLocation(String? locationId) async {
    final response =
        await _locationStorage.deleteLocation(locationId: locationId);

    emit(state.copyWith(
      isDeleting: false,
    ));
    try {
      if (response) {
        if (locationId != null) {
          state.locations!.removeWhere((element) => element.id == locationId);
        }
        emit(state.copyWith(
          isDeleting: true,
          locations: state.locations,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isDeleting: false,
      ));
      throw ('Error deleting location: $e');
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
      final position = await LocationServiceImpl().getCurrentPosition();
      final address = await LocationServiceImpl().getAddressFromLatLng(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      _addressController.text = address;
      emit(state.copyWith(
        currentLocation: LatLng(position.latitude, position.longitude),
        latitude: position.latitude,
        longitude: position.longitude,
        isLoading: false,
      ));
      print(
          'State : ${state.latitude}, ${state.longitude},${state.currentLocation}}');
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
      ));
      throw ('Error getting current location: $e');
    }
  }

  void deleteCurrentLocation() {
    emit(state.copyWith(
      currentLocation: null,
    ));
  }

  Future<List<Marker>> multipleMarker(List<LocationModel>? response) async {
    List<Marker> markers = [];
    final currentIcon =
        await _createMarkerImageFromAsset(Assets.icons.icCurrent.path);
    final icon = await _createMarkerImageFromAsset(Assets.icons.icFavorite.path);
    markers.add(Marker(
      icon: currentIcon,
      markerId: MarkerId('current_location'),
      position: LatLng(state.latitude!, state.longitude!),
      infoWindow: InfoWindow(
        title: 'Current Location',
      ),
    ));
    if (response != null) {
      for (var position in response) {
        if (position.picture != null) {
          markers.add(Marker(
            icon: icon,
            markerId: MarkerId(position.id!),
            position: LatLng(position.latitude!, position.longitude!),
            infoWindow: InfoWindow(
              title: position.title,
            ),
          ));
        } else {
          markers.add(Marker(
            markerId: MarkerId(position.id!),
            position: LatLng(position.latitude!, position.longitude!),
            infoWindow: InfoWindow(
              title: position.title,
            ),
          ));
        }
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

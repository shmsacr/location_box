import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/core/service/location_service/location_service_impl.dart';
import 'package:location_box/app/core/service/location_storage/location_storage_impl.dart';
import 'package:location_box/app/feature/view/home/view_model/state/home_state.dart';
import 'package:location_box/app/product/model/location/location_model.dart';
import 'package:location_box/app/product/model/my_view_model.dart';
import 'package:location_box/gen/src/asset/assets.gen.dart';
import 'package:uuid/uuid.dart';

class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel() : super(HomeState());
  final LocationStorageImpl _locationStorage = LocationStorageImpl();
  final MyViewModel getIt = GetIt.instance.get<MyViewModel>();

  void searchLocation(String query) {
    emit(state.copyWith(isSearching: true));
    if (state.lastSearchLenght < query.length) {
      emit(
        state.copyWith(
          isSearching: state.isSearching,
          isLoading: state.isLoading,
          locations: (state.searchMaps ?? [])
              .where(
                (element) => element.title!.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList(),
        ),
      );
    } else if (query.isNotEmpty && query.length > 0) {
      emit(
        state.copyWith(
          lastSearchLenght: query.length,
          isSearching: state.isSearching,
          isLoading: state.isLoading,
          locations: (state.locations ?? [])
              .where(
                (element) => element.title!.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList(),
        ),
      );
    } else {
      emit(state.copyWith(
          lastSearchLenght: query.length,
          locations: state.searchMaps,
          isSearching: state.isSearching,
          isLoading: state.isLoading));
    }
  }

  void clearSearch() {
    emit(state.copyWith(isSearching: false));
  }

  Future<void> saveLocation(File? imagePath) async {
    final _formKey = getIt.formKey;
    try {
      print('_formKey.currentState: ${_formKey.currentState}');
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        DateTime now = DateTime.now();
        final String? _id = Uuid().v4();
        print('ID : $_id');
        emit(state.copyWith(latitude: state.latitude! + 0.01));
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
            'iconPath':
                getIt.iconController?.text ?? Assets.icons.icDefault.path,
          },
        );
        final response =
            await _locationStorage.addLocation(location: _location);
        emit(state.copyWith(
          isSaving: false,
        ));
        if (response) {
          final icon = await _createMarkerImageFromAsset(_location.iconPath!);
          final markers = Marker(
            icon: icon,
            markerId: MarkerId(_location.id!),
            position: LatLng(_location.latitude!, _location.longitude!),
            onTap: () => print('Marker tapped'),
          );
          emit(state.copyWith(
            isSaving: true,
            locations: state.locations == null
                ? [_location]
                : [...state.locations!, _location],
            searchMaps: state.searchMaps == null
                ? [_location]
                : [...state.searchMaps!, _location],
            markers: [...state.markers!, markers],
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
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final response = await _locationStorage.getAllLocations();
      emit(state.copyWith(
          locations: response.isNotEmpty ? response : null,
          isLoading: false,
          searchMaps: response.isNotEmpty ? response : null));
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
          state.markers!
              .removeWhere((element) => element.markerId.value == locationId);
        }
        emit(state.copyWith(
          isDeleting: true,
          locations: state.locations!.length > 0 ? state.locations : null,
          markers: state.markers,
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
      getIt.addressController.text = address;
      emit(state.copyWith(
        currentLocation: LatLng(position.latitude, position.longitude),
        latitude: position.latitude,
        longitude: position.longitude,
        isLoading: false,
      ));
      multipleMarker();
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

  Future<void> updateLocation(LocationModel _locationModel) async {
    final _formKey = getIt.formKey;
    try {
     
        final response =
            await _locationStorage.updateLocation(location: _locationModel);
        if (response.id == _locationModel.id) {
          final updatedLocations = List<LocationModel>.from(state.locations!);
          final index =
              updatedLocations.indexWhere((loc) => loc.id == _locationModel.id);
          if (index != -1) {
            updatedLocations[index] = _locationModel;

            emit(state.copyWith(
              locations: updatedLocations,
            ));
          }
        }
      
    } catch (e) {}
  }

  Future<List<Marker>> multipleMarker() async {
    List<Marker> markers = [];
    final currentIcon =
        await _createMarkerImageFromAsset(Assets.icons.icCurrent.path);

    markers.add(Marker(
      icon: currentIcon,
      markerId: MarkerId('current_location'),
      position: LatLng(state.latitude!, state.longitude!),
      infoWindow: InfoWindow(
        title: 'Current Location',
      ),
    ));
    if (state.locations != null) {
      for (var position in state.locations!) {
        final icon = await _createMarkerImageFromAsset(position.iconPath!);
        markers.add(Marker(
          icon: icon,
          markerId: MarkerId(position.id!),
          onTap: () {
            print('Marker tapped');
          },
          position: LatLng(position.latitude!, position.longitude!),
        ));
      }
    }
    emit(state.copyWith(
      markers: markers,
    ));

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

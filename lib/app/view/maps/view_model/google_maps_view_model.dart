import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/core/service/location_service/location_storage_impl.dart';
import 'package:location_box/app/product/model/location/location.dart';
import 'package:location_box/app/view/maps/view_model/state/google_maps_state.dart';

class GoogleMapsViewModel extends Cubit<GoogleMapsState> {
  GoogleMapsViewModel() : super(GoogleMapsState());

  final locationStorage = LocationStorageImpl();
  Future<void> saveLocation(Location location) async {
    final response = await locationStorage.addLocation(location: location);
    emit(state.copyWith(
      isSaving: false,
    ));
    if (response) {
      emit(state.copyWith(
        locations: List.from(state.locations ?? [])..add(location),
        isSaving: true,
      ));
    }
    print('State : ${state.locations}');
  }

  Future<void> getLocations() async {
    final response = await locationStorage.getAllLocations();
    emit(state.copyWith(
      isLoading: false,
    ));
    if (response.isNotEmpty) {
      emit(state.copyWith(
        locations: response,
        isLoading: true,
      ));
    }
  }

  void deleteCurrentLocation() {
    emit(state.copyWith(
      currentLocation: null,
    ));
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

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
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
      print('Error getting current location: $e');
    }
  }
}

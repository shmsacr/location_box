import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location_box/app/core/service/location_service/location_storage_impl.dart';
import 'package:location_box/app/product/model/location/location.dart';
import 'package:location_box/app/view/maps/view_model/state/google_maps_state.dart';
import 'package:uuid/uuid.dart';

final class GoogleMapsViewModel extends Cubit<GoogleMapsState> {
  GoogleMapsViewModel() : super(GoogleMapsState());
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late final GoogleMapController _mapController;
  final TextEditingController _titleController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  TextEditingController get addressController => _addressController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get imageController => _imageController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get titleController => _titleController;
  GlobalKey<FormBuilderState> get formKey => _formKey;
  GoogleMapController get mapController => _mapController;

  GoogleMapController? setMapController(GoogleMapController controller) {
    _mapController = controller;
    return _mapController;
  }

  final LocationStorageImpl _locationStorage = LocationStorageImpl();

  Future<void> saveLocation() async {
    print('_formKey.currentState: ${_formKey.currentState}');
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      DateTime now = DateTime.now();
      final String? _id = Uuid().v4();
      final x = DateFormat('yyyyMMddHHss').format(now);
      print(x);
      print('ID : $_id');
      final Location _location = Location.fromJson(
        {
          'id': _id,
          'title': _formKey.currentState!.value['title'],
          'address': _formKey.currentState!.value['address'],
          'description': _formKey.currentState!.value['description'],
          'image': _formKey.currentState!.value['image'],
          'phone': _formKey.currentState!.value['phone'],
          'latitude': state.latitude,
          'longitude': state.longitude,
          'createdAt': now.toString(),
        },
      );
      final response = await _locationStorage.addLocation(location: _location);
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
  }

  Future<void> getLocations() async {
    final response = await _locationStorage.getAllLocations();
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

  Future<void> deleteLocation(Location location) async {
    final response = await _locationStorage.deleteLocation(location: location);
    emit(state.copyWith(
      isDeleting: false,
    ));
    try {
      if (response) {
        if (location.id != null) {
          state.locations!.removeWhere((element) => element.id == location.id);
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

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
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
      throw ('Error getting current location: $e');
    }
  }

  void deleteCurrentLocation() {
    emit(state.copyWith(
      currentLocation: null,
    ));
  }
}

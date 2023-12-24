import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/product/model/location/location_model.dart';

final class GoogleMapsState extends Equatable {
  final List<LocationModel>? locations;
  final LocationModel? location;
  final bool isLoading;
  final bool isSaving;
  final bool isDeleting;
  final LatLng? currentLocation;
  final double? latitude;
  final double? longitude;
  GoogleMapsState({
    this.locations,
    this.location,
    this.isLoading = false,
    this.isSaving = false,
    this.isDeleting = false,
    this.currentLocation,
    this.latitude,
    this.longitude,
  });

  GoogleMapsState copyWith({
    List<LocationModel>? locations,
    LocationModel? location,
    bool? isLoading,
    bool? isSaving,
    bool? isDeleting,
    LatLng? currentLocation,
    double? latitude,
    double? longitude,
  }) {
    return GoogleMapsState(
      locations: locations ?? this.locations,
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isDeleting: isDeleting ?? this.isDeleting,
      currentLocation: currentLocation ?? this.currentLocation,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<Object?> get props => [
        locations,
        location,
        isLoading,
        isDeleting,
        isSaving,
        currentLocation,
        latitude,
        longitude,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_box/app/product/model/location/location_model.dart';

final class HomeState extends Equatable {
  final bool isSearching;
  final bool isLoading;
  final List<LocationModel>? searchMaps;
  final List<LocationModel>? locations;
  final int lastSearchLenght;
  final LocationModel? location;
  final bool isSaving;
  final bool isDeleting;
  final LatLng? currentLocation;
  final double? latitude;
  final double? longitude;
  final List<Marker>? markers;

  HomeState({
    this.isLoading = false,
    this.isSearching = false,
    this.searchMaps,
    this.locations,
    this.lastSearchLenght = 0,
    this.location,
    this.isSaving = false,
    this.isDeleting = false,
    this.currentLocation,
    this.latitude,
    this.longitude,
    this.markers,

  });

  HomeState copyWith({
    bool? isSearching,
    bool? isLoading,
    List<LocationModel>? searchMaps,
    List<LocationModel>? locations,
    int? lastSearchLenght,
    LocationModel? location,
    bool? isSaving,
    bool? isDeleting,
    LatLng? currentLocation,
    double? latitude,
    double? longitude,
    List<Marker>? markers,
  }) {
    return HomeState(
      isSearching: isSearching ?? this.isSearching,
      isLoading: isLoading ?? this.isLoading,
      searchMaps: searchMaps ?? this.searchMaps,
      locations: locations ?? this.locations,
      lastSearchLenght: lastSearchLenght ?? this.lastSearchLenght,
      location: location ?? this.location,
      isSaving: isSaving ?? this.isSaving,
      isDeleting: isDeleting ?? this.isDeleting,
      currentLocation: currentLocation ?? this.currentLocation,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      markers: markers ?? this.markers,

    );
  }

  @override
  List<Object?> get props => [isSearching, searchMaps, locations, isLoading, lastSearchLenght, location, isSaving, isDeleting, currentLocation, latitude, longitude, markers,];
}

import 'package:equatable/equatable.dart';
import 'package:location_box/app/product/model/location/location_model.dart';

final class HomeState extends Equatable {
  final bool isSearching;
  final bool isLoading;
  final List<LocationModel>? searchMaps;
  final List<LocationModel>? locations;

  HomeState({
    this.isLoading = false,
    this.isSearching = false,
    this.searchMaps,
    this.locations,
  });

  HomeState copyWith({
    bool? isSearching,
    bool? isLoading,
    List<LocationModel>? searchMaps,
    List<LocationModel>? locations,
  }) {
    return HomeState(
      isSearching: isSearching ?? this.isSearching,
      isLoading: isLoading ?? this.isLoading,
      searchMaps: searchMaps ?? this.searchMaps,
      locations: locations ?? this.locations,
    );
  }

  @override
  List<Object?> get props => [isSearching, searchMaps, locations, isLoading];
}

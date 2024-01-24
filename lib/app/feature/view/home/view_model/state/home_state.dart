import 'package:equatable/equatable.dart';
import 'package:location_box/app/product/model/location/location_model.dart';

final class HomeState extends Equatable {
  final bool isSearching;
  final bool isLoading;
  final List<LocationModel>? searchMaps;
  final List<LocationModel>? locations;
  final int lastSearchLenght;

  HomeState({
    this.isLoading = false,
    this.isSearching = false,
    this.searchMaps,
    this.locations,
    this.lastSearchLenght = 0,
  });

  HomeState copyWith({
    bool? isSearching,
    bool? isLoading,
    List<LocationModel>? searchMaps,
    List<LocationModel>? locations,
    int? lastSearchLenght,
  }) {
    return HomeState(
      isSearching: isSearching ?? this.isSearching,
      isLoading: isLoading ?? this.isLoading,
      searchMaps: searchMaps ?? this.searchMaps,
      locations: locations ?? this.locations,
      lastSearchLenght: lastSearchLenght ?? this.lastSearchLenght,
    );
  }

  @override
  List<Object?> get props => [isSearching, searchMaps, locations, isLoading, lastSearchLenght];
}

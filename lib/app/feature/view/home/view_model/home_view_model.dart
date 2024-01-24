import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_box/app/core/service/location_storage/location_storage_impl.dart';
import 'package:location_box/app/feature/view/home/view_model/state/home_state.dart';

class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel() : super(HomeState());
  final LocationStorageImpl _locationStorage = LocationStorageImpl();

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

  Future<void> getLocations() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      final response = await _locationStorage.getAllLocations();
      emit(state.copyWith(
        locations: response.isNotEmpty ? response : null,
        isLoading: false,
        searchMaps: response.isNotEmpty ? response : null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
      ));
      throw ('Error getting locations: $e');
    }
  }
}

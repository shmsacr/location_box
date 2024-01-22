import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_box/app/core/service/location_storage/location_storage_impl.dart';
import 'package:location_box/app/feature/view/home/view_model/state/home_state.dart';

class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel() : super(HomeState());
  final LocationStorageImpl _locationStorage = LocationStorageImpl();

  String _searchText = '';
  void searchLocation(String query) {
    _searchText = query;

    emit(state.copyWith(isSearching: true));
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
          ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
      ));
      throw ('Error getting locations: $e');
    }
  }
}
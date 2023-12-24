import '../../../product/model/location/location_model.dart';

abstract class LocationStorage {
  Future<bool> addLocation({required LocationModel location});
  Future<LocationModel> getLocation({required LocationModel location});
  Future<List<LocationModel>> getAllLocations();
  Future<bool> deleteLocation({required LocationModel location});
  Future<LocationModel> updateLocation({required LocationModel location});
}

import '../../../product/model/location/location.dart';

abstract class LocationStorage {
  Future<void> addLocation({required Location location});
  Future<Location> getLocation({required Location location});
  Future<List<Location>> getAllLocations();
  Future<bool> deleteLocation({required Location location});
  Future<Location> updateLocation({required Location location});
}

import 'package:hive/hive.dart';

import '../../../product/model/location/location_model.dart';
import 'location_storage.dart';

final class LocationStorageImpl implements LocationStorage {
  static const String _boxName = 'locationBox';

  @override
  Future<bool> addLocation({required LocationModel location}) async {
    Box<LocationModel> box = await Hive.openBox<LocationModel>(_boxName);
    await box.put(location.id, location);
    await box.close();
    return true;
  }

  @override
  Future<bool> deleteLocation({required LocationModel location}) async {
    Box<LocationModel> box = await Hive.openBox<LocationModel>(_boxName);
    await box.delete(location.id);
    await box.close();
    return true;
  }

  @override
  Future<List<LocationModel>> getAllLocations() async {
    Box<LocationModel> box = await Hive.openBox<LocationModel>(_boxName);
    List<LocationModel> locationList =
        box.values.cast<LocationModel>().toList();
    await box.close();
    return locationList;
  }

  @override
  Future<LocationModel> getLocation({required LocationModel location}) async {
    Box<LocationModel> box = await Hive.openBox<LocationModel>(_boxName);
    LocationModel? retrievedLocation = box.get(location.id);
    await box.close();
    return (retrievedLocation) ??
        LocationModel(
            id: '', title: '', address: '', latitude: 0, longitude: 0);
  }

  @override
  Future<LocationModel> updateLocation(
      {required LocationModel location}) async {
    Box<LocationModel> box = await Hive.openBox<LocationModel>(_boxName);
    await box.put(location.id, location);
    await box.close();
    return location;
  }
}

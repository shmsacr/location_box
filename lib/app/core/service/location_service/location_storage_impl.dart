import 'package:hive/hive.dart';
import 'package:location_box/app/product/model/location/location.dart';

import 'location_storage.dart';

final class LocationStorageImpl implements LocationStorage {
  static const String _boxName = 'locationBox';

  @override
  Future<bool> addLocation({required Location location}) async {
    Box<Location> box = await Hive.openBox<Location>(_boxName);
    await box.put(location.id, location);
    await box.close();
    return true;
  }

  @override
  Future<bool> deleteLocation({required Location location}) async {
    Box<Location> box = await Hive.openBox<Location>(_boxName);
    await box.delete(location.id);
    await box.close();
    return true;
  }

  @override
  Future<List<Location>> getAllLocations() async {
    Box<Location> box = await Hive.openBox<Location>(_boxName);
    List<Location> locationList = box.values.cast<Location>().toList();
    await box.close();
    return locationList;
  }

  @override
  Future<Location> getLocation({required Location location}) async {
    Box<Location> box = await Hive.openBox<Location>(_boxName);
    Location? retrievedLocation = box.get(location.id);
    await box.close();
    return (retrievedLocation) ??
        Location(id: 0, title: '', address: '', latitude: 0, longitude: 0);
  }

  @override
  Future<Location> updateLocation({required Location location}) async {
    Box<Location> box = await Hive.openBox<Location>(_boxName);
    await box.put(location.id, location);
    await box.close();
    return location;
  }
}

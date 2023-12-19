import 'package:hive/hive.dart';
import 'package:location_box/app/product/model/location/location.dart';

import 'location_storage.dart';

class LocationStorageImpl implements LocationStorage {
  static const String boxName = 'locationBox';
  @override
  Future<void> addLocation({required Location location}) async {
    Box<Location> box = await Hive.openBox<Location>(boxName);
    await box.put(location.id, location);
    await box.close();
  }

  @override
  Future<bool> deleteLocation({required Location location}) async {
    Box<Location> box = await Hive.openBox<Location>(boxName);
    await box.delete(location.id);
    await box.close();
    return true;
  }

  @override
  Future<List<Location>> getAllLocations() async {
    Box<Location> box = await Hive.openBox<Location>(boxName);
    List<Location> locationList = box.values.cast<Location>().toList();
    await box.close();
    return locationList;
  }

  @override
  Future<Location> getLocation({required Location location}) async {
    Box<Location> box = await Hive.openBox<Location>(boxName);
    Location? retrievedLocation = box.get(location.id);
    await box.close();
    return (retrievedLocation) ??
        Location(id: '', title: '', address: '', latitude: 0, longitude: 0);
  }

  @override
  Future<Location> updateLocation({required Location location}) async {
    Box<Location> box = await Hive.openBox<Location>(boxName);
    await box.put(location.id, location);
    await box.close();
    return location;
  }
}

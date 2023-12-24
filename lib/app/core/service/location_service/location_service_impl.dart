import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_box/app/core/service/location_service/location_service.dart';

class LocationServiceImpl extends LocationService {
  @override
  Future<String> getAddressFromLatLng(
      {required double latitude, required double longitude}) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      }
      return "Adres bulunamad";
    } catch (e) {
      throw Exception("Adres çevirme hatasi: $e");
    }
  }

  @override
  Future<Position> getCurrentPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      return position;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

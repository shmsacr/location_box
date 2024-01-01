import 'package:geolocator/geolocator.dart';

abstract class LocationService{
  Future<Position> getCurrentPosition();
  Future<String> getAddressFromLatLng({required double latitude, required double longitude});
}
// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  static LocationPermission? permission;

  Future<void> getCurrentLocation() async {
    permission = await Geolocator.requestPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}

import 'package:geolocator/geolocator.dart';

enum LocationAccess {
  denied, // Request location permission again
  deniedForever, // Location permissions are denied forever
  allowed,
  notActivated, // Request users to enable the location services.
  unknown,
}

class LocationService {
  Future<LocationAccess> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationAccess.notActivated;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Android's shouldShowRequestPermissionRationale returned true
        return LocationAccess.denied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return LocationAccess.deniedForever;
    }

    return LocationAccess.allowed;
  }

  Future<Position> getCurrentPosition() async =>
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.lowest,
      );
}

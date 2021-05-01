import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:weather/location/repository/location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required locationService})
      : _locationService = locationService,
        super(LocationInitial());

  final LocationService _locationService;

  Future<void> getCurrentLocation() async {
    final locationPermission = await _locationService.getLocationPermission();

    switch (locationPermission) {
      case LocationAccess.notActivated:
        return emitLocationNotActivated();
      case LocationAccess.allowed:
        return emitLocationAllowed();
      case LocationAccess.denied:
      case LocationAccess.deniedForever:
      default:
        return emitLocationDenied();
    }
  }

  void emitLocationNotActivated() => emit(LocationNotActivated());

  void emitLocationDenied() => emit(LocationDenied());

  void emitLocationAllowed() async {
    final position = await _locationService.getCurrentPosition();
    print(position);
    return emit(LocationAllowed(
      latitude: position.latitude,
      longitude: position.longitude,
    ));
  }
}

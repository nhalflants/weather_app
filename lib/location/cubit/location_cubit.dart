import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/location/location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this._locationService) : super(LocationState());

  final LocationService _locationService;

  Future<void> getCurrentLocation() async {
    final locationPermission = await _locationService.getLocationPermission();
    if (locationPermission == LocationAccess.allowed) {
      final position = await _locationService.getCurrentPosition();
      emit(state.copyWith(
        locationAccess: LocationAccess.allowed,
        latitude: position.latitude,
        longitude: position.longitude,
      ));
    } else {
      emit(state.copyWith(locationAccess: locationPermission));
    }
  }
}

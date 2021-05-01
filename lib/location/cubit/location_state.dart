part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationDenied extends LocationState {}

class LocationNotActivated extends LocationState {}

class LocationAllowed extends LocationState {
  LocationAllowed({
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  final double latitude;
  final double longitude;

  LocationState copyWith({
    double? latitude,
    double? longitude,
  }) {
    return LocationAllowed(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

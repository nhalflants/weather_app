part of 'location_cubit.dart';

class LocationState extends Equatable {
  LocationState({
    this.locationAccess = LocationAccess.unknown,
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  final LocationAccess locationAccess;
  final double latitude;
  final double longitude;

  LocationState copyWith({
    LocationAccess? locationAccess,
    double? latitude,
    double? longitude,
  }) {
    return LocationState(
      locationAccess: locationAccess ?? this.locationAccess,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<Object?> get props => [locationAccess, latitude, longitude];
}

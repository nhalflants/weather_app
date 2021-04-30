import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

/// {@template location}
/// A model containing data about a location.
/// {@endtemplate}
@JsonSerializable()
class Location {
  const Location({
    required this.title,
    required this.locationType,
    required this.latLng,
    required this.id,
  });

  final String title;
  final LocationType locationType;
  @JsonKey(name: 'latt_long', fromJson: LatLng.parse, toJson: LatLng.encode)
  final LatLng latLng;
  @JsonKey(name: 'woeid')
  final int id;

  /// Converts a JSON [Map] into a [Location] instance.
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// Converts this [Location] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString() => 'Location($id, $title)';
}

class LatLng {
  const LatLng({required this.latitude, required this.longitude});

  static LatLng parse(String? latlong) {
    assert(latlong != null);
    final parts = latlong!.split(',');
    assert(parts.length == 2);
    return LatLng(
      latitude: double.tryParse(parts[0]) ?? 0,
      longitude: double.tryParse(parts[1]) ?? 0,
    );
  }

  static String encode(LatLng latLng) =>
      '${latLng.latitude},${latLng.latitude}';

  final double latitude;
  final double longitude;
}

enum LocationType {
  @JsonValue('City')
  city,
  @JsonValue('Region')
  region,
  @JsonValue('State')
  state,
  @JsonValue('Province')
  province,
  @JsonValue('Country')
  country,
  @JsonValue('Continent')
  continent
}

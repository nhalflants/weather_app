import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:weather_repository/weather_repository.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Equatable {
  const Weather({
    required this.condition,
    required this.lastUpdated,
    required this.location,
    required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  factory Weather.fromRepository(weather_repository.Weather weather) {
    return Weather(
      condition: weather.condition,
      lastUpdated: DateTime.now(),
      location: weather.location,
      temperature: weather.temperature,
    );
  }

  final WeatherCondition condition;
  final DateTime lastUpdated;
  final String location;
  final double temperature;

  static final Weather empty = Weather(
    condition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    temperature: 0.0,
    location: '-',
  );

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object?> get props => [condition, lastUpdated, location, temperature];

  Weather copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdated,
    String? location,
    double? temperature,
  }) {
    return Weather(
      condition: condition ?? this.condition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
    );
  }
}

enum TemperatureUnits {
  fahrenheit,
  celsius,
}

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

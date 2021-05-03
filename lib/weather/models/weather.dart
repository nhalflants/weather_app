import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:weather_repository/weather_repository.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;
import 'package:meta_weather_api/meta_weather_api.dart' as api
    show WeatherState;

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Equatable {
  const Weather({
    required this.condition,
    required this.state,
    required this.stateDescription,
    required this.lastUpdated,
    required this.location,
    required this.temperature,
    required this.minTemp,
    required this.maxTemp,
    required this.windSpeed,
    required this.airPressure,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  factory Weather.fromRepository(weather_repository.Weather weather) {
    return Weather(
      condition: weather.condition,
      state: weather.state,
      stateDescription: weather.stateDescription,
      lastUpdated: DateTime.now(),
      location: weather.location,
      temperature: weather.temperature,
      minTemp: weather.minTemp,
      maxTemp: weather.maxTemp,
      windSpeed: weather.windSpeed,
      airPressure: weather.airPressure,
      humidity: weather.humidity,
    );
  }

  final WeatherCondition condition;
  final api.WeatherState state;
  final String stateDescription;
  final DateTime lastUpdated;
  final String location;
  final double temperature;
  final double minTemp;
  final double maxTemp;
  final double windSpeed;
  final double airPressure;
  final int humidity;

  IconData get icon => state.weatherIcon;

  static final Weather empty = Weather(
      condition: WeatherCondition.unknown,
      state: api.WeatherState.unknown,
      stateDescription: ' ',
      lastUpdated: DateTime(0),
      temperature: 0.0,
      location: '-',
      minTemp: 0.0,
      maxTemp: 0.0,
      windSpeed: 0.0,
      airPressure: 0.0,
      humidity: 0);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object?> get props => [condition, lastUpdated, location, temperature];

  Weather copyWith({
    WeatherCondition? condition,
    api.WeatherState? state,
    String? stateDescription,
    DateTime? lastUpdated,
    String? location,
    double? temperature,
    double? minTemp,
    double? maxTemp,
    double? windSpeed,
    double? airPressure,
    int? humidity,
  }) {
    return Weather(
      condition: condition ?? this.condition,
      state: state ?? this.state,
      stateDescription: stateDescription ?? this.stateDescription,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      windSpeed: windSpeed ?? this.windSpeed,
      airPressure: airPressure ?? this.airPressure,
      humidity: humidity ?? this.humidity,
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

extension on api.WeatherState {
  IconData get weatherIcon {
    switch (this) {
      case api.WeatherState.clear:
        return WeatherIcons.day_sunny;
      case api.WeatherState.lightCloud:
        return WeatherIcons.day_cloudy;
      case api.WeatherState.heavyCloud:
        return WeatherIcons.cloudy;
      case api.WeatherState.showers:
        return WeatherIcons.day_rain;
      case api.WeatherState.lightRain:
        return WeatherIcons.rain;
      case api.WeatherState.heavyRain:
        return WeatherIcons.rain_wind;
      case api.WeatherState.snow:
        return WeatherIcons.snow;
      case api.WeatherState.sleet:
        return WeatherIcons.sleet;
      case api.WeatherState.hail:
        return WeatherIcons.hail;
      case api.WeatherState.thunderstorm:
        return WeatherIcons.thunderstorm;

      default:
        return WeatherIcons.day_sunny;
    }
  }
}

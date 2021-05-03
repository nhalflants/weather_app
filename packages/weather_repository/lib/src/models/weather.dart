import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta_weather_api/meta_weather_api.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Equatable {
  final String location;
  final double temperature;
  final WeatherCondition condition;
  final WeatherState state;
  final String stateDescription;
  final double minTemp;
  final double maxTemp;
  final double windSpeed;
  final double airPressure;
  final int humidity;

  const Weather({
    required this.location,
    required this.temperature,
    required this.condition,
    required this.state,
    required this.stateDescription,
    required this.minTemp,
    required this.maxTemp,
    required this.windSpeed,
    required this.airPressure,
    required this.humidity,
  });

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  @override
  List<Object?> get props => [location, temperature, condition];
}

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

import 'package:meta_weather_api/meta_weather_api.dart' hide Weather;
import 'package:weather_repository/src/models/weather.dart';

class WeatherRepository {
  final MetaWeatherApiClient _weatherApiClient;

  WeatherRepository({MetaWeatherApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? MetaWeatherApiClient();

  Future<Weather> getWeather(String city) async {
    final location = await _weatherApiClient.searchLocation(city);
    final locationId = location.id;
    final weather = await _weatherApiClient.getWeather(locationId);
    return Weather(
      temperature: weather.temp,
      location: location.title,
      condition: weather.weatherStateAbbr.toCondition,
    );
  }
}

class WeatherFailure implements Exception {}

extension on WeatherState {
  WeatherCondition get toCondition {
    switch (this) {
      case WeatherState.clear:
        return WeatherCondition.clear;
      case WeatherState.snow:
      case WeatherState.sleet:
      case WeatherState.hail:
        return WeatherCondition.snowy;
      case WeatherState.thunderstorm:
      case WeatherState.heavyRain:
      case WeatherState.lightRain:
      case WeatherState.showers:
        return WeatherCondition.rainy;
      case WeatherState.heavyCloud:
      case WeatherState.lightCloud:
        return WeatherCondition.cloudy;
      default:
        return WeatherCondition.unknown;
    }
  }
}

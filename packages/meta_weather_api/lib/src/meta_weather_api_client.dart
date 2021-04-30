import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta_weather_api/meta_weather_api.dart';

/// {@template meta_weather_api_client}
/// API client which wraps the [MetaWeather API](https://www.metaweather.com/api/).
/// {@endtemplate}
class MetaWeatherApiClient {
  /// {@macro meta_weather_api_client}
  MetaWeatherApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'www.metaweather.com';
  final http.Client _httpClient;

  /// Search a [Location] `/api/location/search/?query=(query)`.
  Future<Location> searchLocation(String query) async {
    final locationRequest = Uri.https(
        _baseUrl, '/api/location/search', <String, String>{'query': query});
    final locationResponse = await _httpClient.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    final locationJson = jsonDecode(locationResponse.body) as List;

    if (locationJson.isEmpty) {
      throw LocationRequestFailure();
    }

    return Location.fromJson(locationJson.first as Map<String, dynamic>);
  }

  /// Get [Weather] data for a given [locationId]
  Future<Weather> getWeather(int locationId) async {
    final weatherRequest = Uri.https(_baseUrl, '/api/location/$locationId');
    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final weatherJson =
        jsonDecode(weatherResponse.body)['consolidated_weather'] as List;

    if (weatherJson.isEmpty) {
      throw WeatherRequestFailure();
    }

    return Weather.fromJson(weatherJson.first as Map<String, dynamic>);
  }
}

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Represents an error state from an network API request
/// [code] represents the HTTP response code and [message] reason if any
class HttpException implements Exception {
  HttpException(this.code, this.message) : assert(code != null);

  final int? code;
  final String message;

  @override
  String toString() {
    return 'HttpException {code: $code, message: $message}';
  }
}

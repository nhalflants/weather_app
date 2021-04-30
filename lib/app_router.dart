import 'package:flutter/material.dart';
import 'package:weather/core/exceptions/route_exception.dart';
import 'package:weather/search/search.dart';
import 'package:weather/weather/weather.dart';

class AppRouter {
  const AppRouter._();

  static const String weather = 'weather';
  static const String search = 'search';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case weather:
        Object? selectedCity = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => WeatherPage(),
        );
      case search:
        return MaterialPageRoute(
          builder: (_) => SearchPage(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}

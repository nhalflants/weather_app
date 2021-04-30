import 'package:flutter/material.dart';
import 'package:weather/core/exceptions/route_exception.dart';
import 'package:weather/weather/weather.dart';

class AppRouter {
  const AppRouter._();

  static const String weather = 'weather';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case weather:
        return MaterialPageRoute(
          builder: (_) => WeatherPage(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}

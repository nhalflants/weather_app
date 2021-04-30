import 'package:flutter/material.dart';
import 'package:weather/core/exceptions/route_exception.dart';

import 'counter/view/counter_page.dart';

class AppRouter {
  const AppRouter._();

  static const String counter = 'weather';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case counter:
        return MaterialPageRoute(
          builder: (_) => CounterPage(),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
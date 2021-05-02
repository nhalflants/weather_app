import 'package:flutter/material.dart';
import 'package:weather/weather/weather.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({
    Key? key,
    required this.weather,
    required this.units,
  }) : super(key: key);

  final Weather weather;
  final TemperatureUnits units;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          child: Image.asset('assets/welcome.jpg'),
        ),
        SafeArea(
            child: Column(
          children: [
            Text(weather.location),
            Text(
              '${weather.temperature}',
            ),
          ],
        ))
      ],
    );
  }
}

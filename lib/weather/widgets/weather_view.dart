import 'package:flutter/material.dart';
import 'package:weather/weather/weather.dart';
import 'package:weather/weather/widgets/current_conditions.dart';
import 'package:weather/weather/widgets/current_temperature.dart';
import 'package:weather/weather/widgets/high_low_temp.dart';
import 'package:weather_icons/weather_icons.dart';

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
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Text(
            weather.location.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 32,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            weather.stateDescription,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          BoxedIcon(
            weather.icon,
            size: 70,
          ),
          CurrentTemperature(temp: weather.temperature),
          HighLowTemp(minTemp: weather.minTemp, maxTemp: weather.maxTemp),
          const SizedBox(
            height: 15,
          ),
          CurrentConditions(
            humidity: weather.humidity,
            pressure: weather.airPressure,
            windSpeed: weather.windSpeed,
          ),
        ],
      ),
    );
  }
}

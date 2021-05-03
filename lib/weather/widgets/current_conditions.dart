import 'package:flutter/material.dart';

import 'package:weather_icons/weather_icons.dart';

class CurrentConditions extends StatelessWidget {
  const CurrentConditions({
    Key? key,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
  }) : super(key: key);

  final int humidity;
  final double pressure;
  final double windSpeed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildItem('wi-raindrop', humidity.toDouble(), '%', context),
        _buildItem('wi-strong-wind', windSpeed, 'mph', context),
        _buildItem('wi-barometer', pressure, 'mm', context),
      ],
    );
  }

  Widget _buildItem(String iconWeatherCode, double condition, String unit,
      BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BoxedIcon(
          WeatherIcons.fromString(iconWeatherCode),
          size: 30,
        ),
        // Text(
        //   '$condition',
        //   style: const TextStyle(
        //     fontWeight: FontWeight.w200,
        //     fontSize: 22,
        //   ),
        // ),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                ),
            children: [
              TextSpan(
                text: '${condition.round()}',
              ),
              TextSpan(
                text: '$unit',
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather/weather/weather.dart';

class CurrentTemperature extends StatefulWidget {
  const CurrentTemperature({
    Key? key,
    required this.temp,
  }) : super(key: key);

  final double temp;
  @override
  _CurrentTemperatureState createState() => _CurrentTemperatureState();
}

class _CurrentTemperatureState extends State<CurrentTemperature> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '${widget.temp.round()}',
          style: const TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 80,
          ),
        ),
        BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return Text(
              state.temperatureUnits == TemperatureUnits.celsius ? '°C' : '°F',
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 30,
              ),
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/app_router.dart';
import 'package:weather/location/location.dart';
import 'package:weather/weather/weather.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationInitial) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return WeatherPageView();
        }
      },
    );
  }
}

class WeatherPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              await Navigator.of(context)
                  .pushNamed(AppRouter.search)
                  .then((city) {
                context.read<WeatherCubit>().fetchCityWeather(city.toString());
              });
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherInitial();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                return WeatherView(
                  weather: state.weather,
                  units: state.temperatureUnits,
                );
              case WeatherStatus.failure:
              default:
                return const WeatherError();
            }
          },
        ),
      ),
    );
  }
}

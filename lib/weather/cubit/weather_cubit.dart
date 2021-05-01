import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/location/location.dart';
import 'package:weather/weather/models/weather.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherRepository;

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({
    required WeatherRepository weatherRepository,
    required LocationCubit locationCubit,
  })   : _weatherRepository = weatherRepository,
        _locationCubit = locationCubit,
        super(WeatherState()) {
    _locationSubscription = _locationCubit.stream.listen((state) {
      if (state is LocationAllowed) {
        fetchWeather('London');
      }
    });
  }

  final WeatherRepository _weatherRepository;

  final LocationCubit _locationCubit;
  late final StreamSubscription _locationSubscription;

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;

    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = await _weatherRepository.getWeather(city);
      final weatherModel = Weather.fromRepository(weather);
      final units = state.temperatureUnits;
      final tempValue = units.isFahrenheit
          ? weather.temperature.toFahrenheit()
          : weather.temperature.toCelsius();

      emit(state.copyWith(
        status: WeatherStatus.success,
        temperatureUnits: units,
        weather: weatherModel.copyWith(temperature: tempValue),
      ));
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  @override
  Future<void> close() {
    _locationSubscription.cancel();
    return super.close();
  }
}

extension on double {
  double toFahrenheit() => ((this * 9 / 5) + 32);
  double toCelsius() => ((this - 32) * 5 / 9);
}

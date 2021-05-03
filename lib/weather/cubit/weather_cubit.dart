import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/location/location.dart';
import 'package:weather/weather/models/weather.dart';
import 'package:weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherRepository;

part 'weather_cubit.g.dart';
part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit({
    required WeatherRepository weatherRepository,
    required LocationCubit locationCubit,
  })   : _weatherRepository = weatherRepository,
        _locationCubit = locationCubit,
        super(WeatherState()) {
    _locationSubscription = _locationCubit.stream.listen((locationState) {
      if (locationState is LocationAllowed &&
          state.status != WeatherStatus.success) {
        fetchLatLngWeather(locationState.latitude, locationState.longitude);
      }
    });
  }

  final WeatherRepository _weatherRepository;

  final LocationCubit _locationCubit;
  late final StreamSubscription _locationSubscription;

  double temperatureToUnit(double temperature) =>
      state.temperatureUnits.isFahrenheit
          ? temperature.toFahrenheit()
          : temperature;

  void emitWeatherModel(Weather weatherModel) {
    emit(state.copyWith(
      status: WeatherStatus.success,
      temperatureUnits: state.temperatureUnits,
      weather: weatherModel.copyWith(
          temperature: temperatureToUnit(weatherModel.temperature)),
    ));
  }

  Future<void> fetchLatLngWeather(double lat, double lng) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final weather = await _weatherRepository.getWeatherForLatLng(
          lat.toStringAsFixed(3), lng.toStringAsFixed(3));
      final weatherModel = Weather.fromRepository(weather);
      emitWeatherModel(weatherModel);
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> fetchCityWeather(String? city) async {
    if (city == null || city.isEmpty) return;

    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = await _weatherRepository.getWeatherForCity(city);
      final weatherModel = Weather.fromRepository(weather);
      emitWeatherModel(weatherModel);
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> refreshWeather() async {
    if (state.status != WeatherStatus.success) return;
    if (state.weather == Weather.empty) return;
    try {
      final weather =
          await _weatherRepository.getWeatherForCity(state.weather.location);
      final weatherModel = Weather.fromRepository(weather);
      emitWeatherModel(weatherModel);
    } on Exception {
      emit(state);
    }
  }

  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    if (state.status != WeatherStatus.success) {
      emit(state.copyWith(temperatureUnits: units));
      return;
    }

    if (state.weather != Weather.empty) {
      final temp = units.isFahrenheit
          ? state.weather.temperature.toFahrenheit()
          : state.weather.temperature.toCelsius();
      emit(state.copyWith(
        temperatureUnits: units,
        weather: state.weather.copyWith(temperature: temperatureToUnit(temp)),
      ));
    }
  }

  @override
  Future<void> close() {
    _locationSubscription.cancel();
    return super.close();
  }

  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic> toJson(WeatherState state) => state.toJson();
}

extension on double {
  double toFahrenheit() => ((this * 9 / 5) + 32);
  double toCelsius() => ((this - 32) * 5 / 9);
}

import 'package:bloc/bloc.dart';
import 'package:weather/weather/models/weather.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherRepository;

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherState());

  final WeatherRepository _weatherRepository;

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
}

extension on double {
  double toFahrenheit() => ((this * 9 / 5) + 32);
  double toCelsius() => ((this - 32) * 5 / 9);
}

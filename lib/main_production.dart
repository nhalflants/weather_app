import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:weather/app/app.dart';
import 'package:weather/app/app_bloc_observer.dart';
import 'package:weather/location/location.dart';
import 'package:weather_repository/weather_repository.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };

    // await Firebase.initializeApp();
    runApp(
      App(
        weatherRepository: WeatherRepository(),
        locationService: LocationService(),
      ),
    );
  }, (Object error, StackTrace stackTrace) {
    log(error.toString(), stackTrace: stackTrace);
  });
}

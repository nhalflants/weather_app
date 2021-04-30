import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:weather/app/app.dart';
import 'package:weather/app/app_bloc_observer.dart';
import 'package:weather_repository/weather_repository.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  // runs body in its own error zone.
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };

    // await Firebase.initializeApp();
    runApp(
      App(
        weatherRepository: WeatherRepository(),
      ),
    );
  }, (Object error, StackTrace stackTrace) {
    log(error.toString(), stackTrace: stackTrace);
  });
}

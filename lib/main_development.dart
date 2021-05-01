import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather/app/app.dart';
import 'package:weather/app/app_bloc_observer.dart';
import 'package:weather/location/location.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  // runs body in its own error zone.
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );

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

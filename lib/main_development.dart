// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:weather/app/app.dart';
import 'package:weather/app/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  // runs body in its own error zone.
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };

    // await Firebase.initializeApp();
    runApp(const App());
  }, (Object error, StackTrace stackTrace) {
    log(error.toString(), stackTrace: stackTrace);
  });
}

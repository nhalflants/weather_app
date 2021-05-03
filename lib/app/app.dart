import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather/app_router.dart';
import 'package:weather/core/themes/app_theme.dart';
import 'package:weather/l10n/l10n.dart';
import 'package:weather/location/cubit/location_cubit.dart';
import 'package:weather/location/location.dart';
import 'package:weather/theme/cubit/theme_cubit.dart';
import 'package:weather/weather/cubit/weather_cubit.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:sizer/sizer.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required WeatherRepository weatherRepository,
    required LocationService locationService,
  })   : _weatherRepository = weatherRepository,
        _locationService = locationService,
        super(key: key);

  final WeatherRepository _weatherRepository;
  final LocationService _locationService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ThemeCubit>(
        create: (context) => ThemeCubit(),
      ),
      BlocProvider<LocationCubit>(
        create: (context) => LocationCubit(locationService: _locationService)
          ..getCurrentLocation(),
      ),
      BlocProvider<WeatherCubit>(
        lazy: false,
        create: (context) => WeatherCubit(
          weatherRepository: _weatherRepository,
          locationCubit: context.read<LocationCubit>(),
        ),
      ),
    ], child: WeatherApp());
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _portraitModeOnly();
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeCubit>().updateTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: context
            .select((ThemeCubit themeCubit) => themeCubit.state.themeMode),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.weather,
        onGenerateRoute: AppRouter.onGenerateRoute,
      );
    });
  }

  /// blocks rotation; sets orientation to portrait
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

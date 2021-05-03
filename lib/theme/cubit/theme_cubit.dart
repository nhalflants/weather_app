import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/themes/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.light));

  void updateTheme() {
    final Brightness currentBirghtness = AppTheme.currentSystemBrightness;
    currentBirghtness == Brightness.light
        ? _setTheme(ThemeMode.light)
        : _setTheme(ThemeMode.dark);
  }

  void _setTheme(ThemeMode themeMode) {
    AppTheme.setStatusBarAndNavigationBarColor(themeMode);
    emit(ThemeState(themeMode: themeMode));
  }
}

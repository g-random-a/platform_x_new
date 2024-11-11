import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/tasks_management/services/hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../event/theme_event.dart';
import '../state/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool isDarkMode = false;
  TaskManagerService taskManagerService;

  ThemeBloc( {required this.taskManagerService}) : super(LightThemeState()) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  Future<void> _onLoadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getBool('isDarkMode'); 
    if (savedTheme != null) {
      isDarkMode = savedTheme;
      emit(isDarkMode ? DarkThemeState() : LightThemeState());
    } else {
      final brightness = PlatformDispatcher.instance.platformBrightness;
      isDarkMode = brightness == Brightness.dark;
      emit(isDarkMode ? DarkThemeState() : LightThemeState());
    }
  }

  Future<void> _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    isDarkMode = !isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);  // Save theme preference to SharedPreferences
    emit(isDarkMode ? DarkThemeState() : LightThemeState());
  }
}

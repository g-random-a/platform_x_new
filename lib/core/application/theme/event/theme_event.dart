import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {} // Event to toggle between light and dark mode

class LoadThemeEvent extends ThemeEvent {}    // Event to load the theme on app start

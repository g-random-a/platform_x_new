import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:platform_x/core/utils/theme/app_colors.dart';

import '../../../utils/theme/theme_constants.dart';

abstract class ThemeState extends Equatable {
  final ThemeData themeData;
  final AppColorTheme appColorTheme;

  const ThemeState(this.themeData, this.appColorTheme);

  @override
  List<Object?> get props => [themeData, appColorTheme];
}

class LightThemeState extends ThemeState {
  LightThemeState() : super(ThemeManager.lightTheme(), CodeColors());

  @override
  List<Object?> get props => [themeData, appColorTheme];

}

class DarkThemeState extends ThemeState {
  DarkThemeState() : super(ThemeManager.darkTheme(), CodeColorsDark());

  @override
  List<Object?> get props => [themeData, appColorTheme];

}
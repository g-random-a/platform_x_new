import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platform_x/core/utils/theme/app_colors.dart';
import 'package:platform_x/core/utils/theme/text_theme.dart';

class ThemeManager {
  static ThemeData themeData = ThemeData(
    textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    elevatedButtonTheme: ElevatedButtonTheme.ElevetedButtonTheme,
    dividerTheme: DividerTheme.dividerTheme, 
  );

  static ThemeData lightTheme() {
    AppColorTheme appColorTheme = CodeColors();
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0XFFF4F4F4),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      ),
      textTheme: TextThemes.textTheme(appColorTheme),
      colorScheme: ColorSchemes.lightCodeColorScheme,
    );
  }

  // Dark Theme
  static ThemeData darkTheme() {
    AppColorTheme appColorTheme = CodeColorsDark();
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blueGrey,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      ),
      textTheme: TextThemes.textTheme(appColorTheme),
      colorScheme: ColorSchemes.darkCodeColorSchema,
    );
  }
}

class ColorSchemes {
  static const lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF0048A6),
    primaryContainer: Color(0XFFE1EFFF),
    secondaryContainer: Color(0XFFD6DDEB),
    onErrorContainer: Color(0X05000000),
    onPrimary: Color(0XFF0D010C),
    onPrimaryContainer: Color(0XFF292D32),
  );

  static const darkCodeColorSchema = ColorScheme.dark(
  primary: Color(0XFF82B4FF), 
  primaryContainer: Color(0XFF0048A6),
  secondaryContainer: Color(0XFF4A5467), 
  onErrorContainer: Color(0XFFFFCDD2), 
  onPrimary: Color(0XFFFFFFFF),
  onPrimaryContainer: Color(0XFFB0BEC5), 
);
}

class ElevatedButtonTheme {
  static var ElevetedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      visualDensity: const VisualDensity(
        vertical: -4,
        horizontal: -4,
      ),
      padding: EdgeInsets.zero,
    ),
  );
}

class DividerTheme {
  static var dividerTheme = const DividerThemeData(
    thickness: 1,
    space: 1,
  );
}

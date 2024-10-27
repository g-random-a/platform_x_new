import 'package:flutter/material.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/app_colors.dart';

class TextThemes {  
static TextTheme textTheme(AppColorTheme appColorTheme) => TextTheme(  
  bodySmall: TextStyle(  
    color: appColorTheme.black900,
    fontSize: 9.fSize,  
    fontFamily: 'Inter',  
    fontWeight: FontWeight.w400,  
  ),  
  labelLarge: TextStyle(  
    color: appColorTheme.blueGray800,  
    fontSize: 12.fSize,  
    fontFamily: 'Inter',  
    fontWeight: FontWeight.w500,  
  ),  
  labelMedium: TextStyle(  
    color: appColorTheme.blueGray800,
    fontSize: 10.fSize,  
    fontFamily: 'Plus Jakarta Sans',  
    fontWeight: FontWeight.w500,  
  ),  
  labelSmall: TextStyle(  
    color: appColorTheme.black90001,
    fontSize: 9.fSize,  
    fontFamily: 'Inter',  
    fontWeight: FontWeight.w600,  
  ),  
  titleLarge: TextStyle(  
    color: appColorTheme.black900,
    fontSize: 23.fSize,  
    fontFamily: 'Plus Jakarta Sans',  
    fontWeight: FontWeight.w800,  
  ),  
  titleMedium: TextStyle(  
    // color: appTheme.whiteA70001,  
    color: appColorTheme.whiteA70001,
    fontSize: 16.fSize,  
    fontFamily: 'Epilogue',  
    fontWeight: FontWeight.w700,  
  ),  
  titleSmall: TextStyle(  
    // color: appTheme.blueGray900,  
    color: appColorTheme.blueGray900,
    fontSize: 14.fSize,  
    fontFamily: 'Inter',  
    fontWeight: FontWeight.w600,  
  ),  
);

}
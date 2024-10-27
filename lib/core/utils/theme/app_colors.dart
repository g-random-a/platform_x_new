import 'package:flutter/material.dart';

abstract class AppColorTheme {
  // Black
  Color get black900;
  Color get black90001;
  Color get black90002;
  Color get black800;
// Blue
  Color get blue200;
  Color get blue50;
  Color get blue700;
  Color get blueA100;
// BlueGray
  Color get blueGray700;
  Color get blueGray800;
  Color get blueGray900;
// Gray
  Color get gray100;
  Color get gray10001;
  Color get gray200;
  Color get gray300;
  Color get gray30001;
  Color get gray600;
  Color get gray900;
  Color get gray90001;

// Green
  Color get green700;
  Color get green200;
  Color get green100;
// Indigo
  Color get indigoA700;
// Orange
  Color get orange50;
  Color get orange600;
// Red
  Color get redA700;
// Teal
  Color get teal1300;
// White
  Color get whiteA700;
  Color get whiteA70001;
// Yellow
  Color get yellow700;
  
}

class CodeColors extends AppColorTheme {
// Black
  @override
  Color get black900 => const Color(0XFF1B0110); 
  @override
  Color get black90001 => const Color(0XFF00030A);
  @override
  Color get black90002 => const Color(0XFF01040B);

  @override
  Color get black800 => const Color(0XFF484C52);

// Blue
  @override
  Color get blue200 => const Color(0XFF8FBFFF);
  @override
  Color get blue50 => const Color(0XFFE1EFFF);
  @override
  Color get blue700 => const Color(0XFF006AE5);
  @override
  Color get blueA100 => const Color(0XFF78B7FF);

// BlueGray
  @override
  Color get blueGray700 => const Color(0XFF515B6F);
  @override
  Color get blueGray800 => const Color(0XFF474851);
  @override
  Color get blueGray900 => const Color(0XFF253248);

// Gray
  @override
  Color get gray100 => const Color(0XFFF3F3F3);
  @override
  Color get gray10001 => const Color(0XFFF5F6F7);
  @override
  Color get gray200 => const Color(0XFFECECEC);
  @override
  Color get gray300 => const Color(0XFFE4E4E4);
  @override
  Color get gray30001 => const Color(0XFFE5E5E5);
  @override
  Color get gray600 => const Color(0XFF848484);
  @override
  Color get gray900 => const Color(0XFF241300);
  @override
  Color get gray90001 => const Color(0XFF7B7B7B);

// Green
  @override
  Color get green700 => const Color(0XFF318E51);
  @override
  Color get green200 => const Color(0XFF318E51);

  @override
  Color get green100 => const Color(0XFFF1F7F3).withOpacity(1);

// Indigo
  @override
  Color get indigoA700 => const Color(0XFF4640DE);

// Orange
  @override
  Color get orange50 => const Color(0XFFFFF3D6);
  @override
  Color get orange600 => const Color(0XFFFF8900);

// Red
  @override
  Color get redA700 => const Color(0XFFFF0000);
  
// Teal
  @override
  Color get teal1300 => const Color(0XFF56CDAD);

// White
  @override
  Color get whiteA700 => const Color(0XFFF4F4F4);
  @override
  Color get whiteA70001 => const Color(0XFFFFFFFF);
  
// Yellow
  @override
  Color get yellow700 => const Color(0XFFFEB835);
}

class CodeColorsDark extends AppColorTheme {
  // white
  @override
  Color get black900 => const Color(0XFFFFFFFF); 
  @override
  Color get black90001 => const Color(0XFFE0E0E0); 
  @override
  Color get black90002 => const Color(0XFFCCCCCC);

  @override
  Color get black800 => const Color(0XFF484C52);

  // blue
  @override
  Color get blue200 => const Color(0XFF6A95D4);  
  @override
  Color get blue50 => const Color(0XFF517AA6);  
  @override
  Color get blue700 => const Color(0XFF0050A1);  
  @override
  Color get blueA100 => const Color(0XFF568AC4); 

  // blueGray
  @override
  Color get blueGray700 => const Color(0XFFB0BEC5); 
  @override
  Color get blueGray800 => const Color(0XFF90A4AE); 
  @override
  Color get blueGray900 => const Color(0XFF78909C); 

  // gray
  @override
  Color get gray100 => const Color(0XFFFAFAFA);  
  @override
  Color get gray10001 => const Color(0XFFF5F5F5);  
  @override
  Color get gray200 => const Color(0XFFEEEEEE); 
  @override
  Color get gray300 => const Color(0XFFE0E0E0); 
  @override
  Color get gray30001 => const Color(0XFFD6D6D6); 
  @override
  Color get gray600 => const Color(0XFF9E9E9E); 
  @override
  Color get gray900 => const Color(0XFF424242);
  @override
  Color get gray90001 => const Color(0XFF7B7B7B);

  // green
  @override
  Color get green700 => const Color(0XFF2E7D32); 
  @override
  Color get green200 => const Color(0XFF318E51);
  @override
  Color get green100 => const Color(0XFFF1F7F3);

  // indigo
  @override
  Color get indigoA700 => const Color(0XFF283593); 

  // orange
  @override
  Color get orange50 => const Color(0XFFFFCC80); 
  @override
  Color get orange600 => const Color(0XFFFFA726); 

  // red
  @override
  Color get redA700 => const Color(0XFFD32F2F); 

  // teal
  @override
  Color get teal1300 => const Color(0XFF00897B); 

  // black
  @override
  Color get whiteA700 => const Color(0XFF121212); 
  @override
  Color get whiteA70001 => const Color(0XFF1A1A1A); 

  // yellow
  @override
  Color get yellow700 => const Color(0XFFFBC02D); 
}

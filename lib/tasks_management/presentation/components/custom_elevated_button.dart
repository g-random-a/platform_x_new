import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_x/core/utils/responsive/size.dart';

import '../../../core/application/theme/bloc/theme_bloc.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? backgroundColor;
  
  final Color? textColor;
  
  final String? text;

  final Function onclick;

  const CustomElevatedButton({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.text,
    required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        // set the width to full 
        minimumSize: WidgetStateProperty.all<Size>(
          Size(double.maxFinite, 42.4.vh),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: 8.h,
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          backgroundColor ?? context.watch<ThemeBloc>().state.themeData.primaryColor,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
        ),
        elevation: WidgetStateProperty.all<double>(0),
        // visualDensity: WidgetStateProperty.all<VisualDensity>(
        //   const VisualDensity(
        //     vertical: -4,
        //   ),
        // ),
      ),
      onPressed: () {
        // go route to /task_instruction - use go routing
        onclick();
      }, 
      child: Text(
        text ?? "Start Task" ,
        style: TextStyle(
          color:  textColor ?? context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
          fontSize: 16.fSize,
          fontWeight: FontWeight.bold,
        )
      )
    );
  }
}

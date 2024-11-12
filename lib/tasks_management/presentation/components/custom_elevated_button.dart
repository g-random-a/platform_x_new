import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/generated/l10n.dart';

import '../../../core/application/theme/bloc/theme_bloc.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? backgroundColor;
  
  final Color? textColor;
  
  final String? text;

  final Function onclick;

  final bool outlined;

  final bool loading;
  final bool disabled;

  const CustomElevatedButton({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.text,
    this.outlined = false,
    required this.onclick,
    this.loading = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(
          Size(double.maxFinite, 42.4.vh),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
            vertical: 10.h,
          ),
        ),
        backgroundColor: !outlined ? WidgetStateProperty.all<Color>(
          backgroundColor ?? context.watch<ThemeBloc>().state.themeData.primaryColor,
        ) : WidgetStateProperty.all<Color>(Colors.transparent),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
            side: BorderSide(
              color: outlined ? backgroundColor ?? context.watch<ThemeBloc>().state.themeData.primaryColor : Colors.transparent,
              width: 2.h,
          ),
        ),),
        elevation: WidgetStateProperty.all<double>(0),
      ),
      onPressed:loading || disabled ? null : () {
        onclick();
      }, 
      child: loading ? 
      SizedBox(
        height: 25.0,  // set desired height
        width: 25.0,  
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(textColor ?? context.watch<ThemeBloc>().state.appColorTheme.whiteA70001),
      ),
            ) :
       Text(
        text ?? S.of(context).t_start_task ,
        style: TextStyle(
          color:  textColor ?? context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
          fontSize: 16.fSize,
          fontWeight: FontWeight.bold,
        )
      )
    );
  }
}

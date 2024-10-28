import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:platform_x/core/utils/responsive/size.dart';

import '../../../../../../core/application/theme/bloc/theme_bloc.dart';

InputDecoration textInputDecoration(BuildContext context, String? suffix, {bool isDate = false}) {
  
  return InputDecoration(
      // hintText: properties.placeholder,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
          borderSide: BorderSide(
            color: context.watch<ThemeBloc>().state.appColorTheme.black90002,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
          borderSide: BorderSide(
            color: context.watch<ThemeBloc>().state.appColorTheme.green700,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
          borderSide: BorderSide(
            color: context.watch<ThemeBloc>().state.appColorTheme.black90002,
          )),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
          borderSide: BorderSide(
            color: context.watch<ThemeBloc>().state.appColorTheme.gray600,
          )),
      // contentPadding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 5.h),
      // suffixText: suffix,
      // suffixStyle: TextStyle(color: context.watch<ThemeBloc>().state.appColorTheme.black90002),
      suffixIcon: isDate ? const Icon(Iconsax.calendar) : 
      suffix != null ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          suffix,
          style: const TextStyle(fontSize: 20),
        ),
      ) : null,
    );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';

import '../../../../../../core/application/theme/bloc/theme_bloc.dart';
import '../../../../../../core/utils/theme/custom_text_styles.dart';

class CheckboxInputField extends StatefulWidget {

  final CheckboxInputValidationSchema validations;
  final CheckboxPropertySchema properties;

  const CheckboxInputField({
    super.key,
    required this.properties,
    required this.validations,
  });

  @override
  _CheckboxInputFieldState createState() => _CheckboxInputFieldState();
}

class _CheckboxInputFieldState extends State<CheckboxInputField> {

  @override
  void initState() {
    super.initState();
  }

  String? validateCheckbox(bool? value) {
    if (widget.validations.required && !value!) {
      return widget.validations.customErrorMessage ?? 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: 
        [
          if(widget.properties.label != null && widget.properties.label!.isNotEmpty) Text(
            widget.properties.label!,
            style: CustomTextStyles.bodySmallPlusJakartaSansBlack90001(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
          ),
          ...List.generate(widget.properties.values.length, 
    (index) => 
       GestureDetector(
      onTap: () {
        setState(() {
          widget.properties.values[index]['selected'] = !(widget.properties.values[index]['selected'] as bool);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 3.6.h),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        height: 47.vh,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.h),
          border: Border.all(
            color: widget.properties.values[index]['selected'] == true
                ? context.watch<ThemeBloc>().state.appColorTheme.green200
                : context.watch<ThemeBloc>().state.appColorTheme.gray90001,
            width: 0.54.h,
          ), // Border color changes based on selection
          color: widget.properties.values[index]['selected'] == true
              ? Colors.green[100]
              : Colors.transparent, // Background color for selected
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: widget.properties.values[index]['selected'] == true,
              onChanged: (bool? value) {
                setState(() {
                  widget.properties.values[index]['selected'] = !(widget.properties.values[index]['selected'] as bool);
                });
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: widget.properties.values[index]['selected'] == true
                        ? context
                            .watch<ThemeBloc>()
                            .state
                            .appColorTheme
                            .green200
                        : context
                            .watch<ThemeBloc>()
                            .state
                            .appColorTheme
                            .gray90001,
                    style: BorderStyle.solid),
              ),
              activeColor: Colors.green,
              checkColor: Colors.white,
            ),
            Text(
              widget.properties.values[index]['value'] as String,
              style: CustomTextStyles.titleRedHatDisplayOnGray90001(
                      context.watch<ThemeBloc>().state.themeData,
                      context.watch<ThemeBloc>().state.appColorTheme)
                  .copyWith(
                color: widget.properties.values[index]['selected'] == true
                    ? context.watch<ThemeBloc>().state.appColorTheme.green700
                    : context.watch<ThemeBloc>().state.appColorTheme.gray90001,
              ),
            ),
          ],
        ),
      ),
    )
    )
    ]
    );
}
}

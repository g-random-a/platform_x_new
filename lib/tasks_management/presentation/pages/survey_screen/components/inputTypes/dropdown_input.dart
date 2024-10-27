import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';

class DropdownInputField extends StatefulWidget {
  
  final DropdownInputValidationSchema validations;
  final DropdownPropertySchema properties;

  const DropdownInputField({
    Key? key,
    required this.validations,
    required this.properties,
  }) : super(key: key);

  @override
  State<DropdownInputField> createState() => _DropdownInputFieldState();
}

class _DropdownInputFieldState extends State<DropdownInputField> {
  
  String? selectedValue;
  
  String? validateDropdown(String? value) {
    if (widget.validations.required && (value == null || value.isEmpty)) {
      return widget.validations.customErrorMessage ?? 'Please select an option';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    selectedValue = widget.properties.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
 
    return DropdownButtonFormField<String>(
      value: selectedValue,
      hint: Text(widget.properties.placeholder ?? 'Select an option'),
      items: widget.properties.options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          enabled: true,
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      validator: validateDropdown,
      style: CustomTextStyles.labelLargePlusJakartaSans(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(color: context.watch<ThemeBloc>().state.themeData.secondaryHeaderColor)
        ),
         focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.h),
          borderSide: BorderSide(color: context.watch<ThemeBloc>().state.appColorTheme.green700)
        ),

      ),
    );
  }
}

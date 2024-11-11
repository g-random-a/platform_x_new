import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/locale/bloc/locale_bloc.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/text_input_decoration.dart';

import '../../../../../domain/inputPropertiesType.dart';

class EmailInputField extends StatefulWidget {
  
  final EmailInputValidationSchema validation;
  final EmailPropertySchema properties;

  const EmailInputField({
    super.key,
    required this.validation,
    required this.properties
  });

  @override
  State<EmailInputField> createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  String? validateEmail(String? value) {
    if (widget.validation.required && (value == null || value.isEmpty)) {
      return widget.validation.customErrorMessage ?? 'This field is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (value != null && !emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        if(widget.properties.label != null && widget.properties.label!.isNotEmpty) Text(
          widget.properties.label!,
          style: CustomTextStyles.bodySmallPlusJakartaSansBlack90001(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
          ),
        TextFormField(
          decoration: textInputDecoration(context, widget.properties.suffix ?? ""),
          initialValue: widget.properties.defaultValue,
          validator: validateEmail,
        ),
      ],
    );
  }
}

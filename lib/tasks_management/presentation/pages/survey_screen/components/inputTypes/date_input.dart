import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/application/theme/bloc/theme_bloc.dart';
import '../../../../../../core/utils/theme/custom_text_styles.dart';
import '../../../../../domain/inputPropertiesType.dart';
import '../../../../../domain/inputValidation.dart';
import 'text_input_decoration.dart';

class DateInputField extends StatefulWidget {
  final DateInputValidationSchema validations;
  final DatePropertySchema properties;

  const DateInputField({
    super.key,
    required this.properties,
    required this.validations,
  });

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  final TextEditingController _controller = TextEditingController();

  String? validateDate(String? value) {
    if (widget.validations.required && (value == null || value.isEmpty)) {
      return widget.validations.customErrorMessage ?? 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(widget.properties.label != null && widget.properties.label!.isNotEmpty) Text(
            widget.properties.label!,
            style: CustomTextStyles.bodySmallPlusJakartaSansBlack90001(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
          ),
        TextFormField(
          controller: _controller,
          // enabled: false,
          readOnly: true,
          decoration: textInputDecoration(context, null, isDate: true),
          initialValue: widget.properties.defaultValue,
          keyboardType: TextInputType.datetime,
          validator: validateDate,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.parse(widget.properties.minDate ?? '1900-01-01'),
              lastDate: DateTime.parse(widget.properties.maxDate ?? '2100-12-31'),
            );
        
            if (pickedDate != null) {
              _controller.text = pickedDate.toLocal().toString().split(' ')[0];
            }
            // Update field with selected date
          },
        ),
      ],
    );
  }
}

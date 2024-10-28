import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';

import '../../../../../../core/application/theme/bloc/theme_bloc.dart';
import '../../../../../../core/utils/theme/custom_text_styles.dart';
import '../../../../../domain/inputPropertiesType.dart';

class RangeInputField extends StatefulWidget {

  final RangeInputValidationSchema validations;
  final RangePropertySchema properties;

  const RangeInputField({
    super.key,
    required this.properties,
    required this.validations
  });

  @override
  _RangeInputFieldState createState() => _RangeInputFieldState();
}

class _RangeInputFieldState extends State<RangeInputField> {
  RangeValues? sliderValue;

  @override
  void initState() {
    super.initState();
    if(widget.properties.defaultMax != null && widget.properties.defaultMin != null) sliderValue = RangeValues(widget.properties.defaultMin!.toDouble(), widget.properties.defaultMax!.toDouble());
  }

  String? validateRange(RangeValues? value) {
    if (widget.validations.required && sliderValue == null) {
      return widget.validations.customErrorMessage ?? 'This field is required';
    }
    return null;
  } 

  @override
  Widget build(BuildContext context) {
    return FormField<RangeValues>(
      validator: validateRange,
      builder: (FormFieldState<RangeValues> field) {
        return Column(
          children: [
            if (widget.properties.label != null &&
                  widget.properties.label!.isNotEmpty)
                Text(
                  widget.properties.label!,
                  style: CustomTextStyles.bodySmallPlusJakartaSansBlack90001(
                      context.watch<ThemeBloc>().state.themeData,
                      context.watch<ThemeBloc>().state.appColorTheme),
                ),
            RangeSlider(
              values: sliderValue ?? RangeValues(widget.properties.min.toDouble(), widget.properties.max.toDouble()),
              min: widget.properties.min.toDouble(),
              max: widget.properties.max.toDouble(),
              divisions: widget.properties.step != null ? widget.properties.max~/widget.properties.step! : widget.properties.max - widget.properties.min,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },

            ),
            if(sliderValue != null) Text('Selected: ${sliderValue?.start} - ${sliderValue?.end}'),
            if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    field.errorText ?? '',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
          ],
        );
      }
    );
  }
}

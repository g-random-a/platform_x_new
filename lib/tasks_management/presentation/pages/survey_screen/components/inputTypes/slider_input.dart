import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';

class SliderInputField extends StatefulWidget {

  final SliderInputValidationSchema validations;
  final SliderPropertySchema properties;

  const SliderInputField({
    super.key,
    required this.validations,
    required this.properties,
  });

  @override
  _SliderInputFieldState createState() => _SliderInputFieldState();
}

class _SliderInputFieldState extends State<SliderInputField> {
  double? sliderValue;

  @override
  void initState() {
    super.initState();
    if (widget.properties.defaultValue != null) sliderValue = widget.properties.defaultValue?.toDouble();
  }

  String? validateSlider(double? value) {
    if (widget.validations.required && sliderValue == null) {
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
          style: CustomTextStyles.bodyMediumInterBlack500(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
        ),
        FormField<double>(
          validator: validateSlider,
          builder: (FormFieldState<double> field) {
            return Column(
              children: [
                Slider(
                  value: sliderValue ?? widget.properties.min.toDouble(),
                  min: widget.properties.min.toDouble(),
                  max: widget.properties.max.toDouble(),
                  divisions: widget.properties.step != null ? (widget.properties.max / widget.properties.step!).round() : widget.properties.max - widget.properties.min,
                  label: sliderValue?.toString(),
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                  },
                  inactiveColor: context.watch<ThemeBloc>().state.appColorTheme.gray200,
                ),
                if(sliderValue != null) Text('Selected: ${sliderValue?.toInt()}'),
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
        ),
      ],
    );
  }
}

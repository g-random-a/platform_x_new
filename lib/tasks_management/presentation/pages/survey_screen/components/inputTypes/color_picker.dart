import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';

import '../../../../../domain/inputPropertiesType.dart';
import '../../../../../domain/inputValidation.dart';


class ColorPickerInputField extends StatefulWidget {
  final ColorPickerPropertySchema properties;
  final ColorPickerInputValidationSchema validations;
  final Color? initialValue;
  final FormFieldSetter<Color>? onSaved;
  final FormFieldValidator<Color>? validator;


  const ColorPickerInputField(
    {super.key, 
      required this.properties,
      required this.validations,
      this.initialValue,
      this.onSaved,
      this.validator,
    }
  );

  @override
  State<ColorPickerInputField> createState() => _ColorPickerInputFieldState();
}

class _ColorPickerInputFieldState extends State<ColorPickerInputField> {
  @override
  Widget build(BuildContext context) {
    return ColorPickerInputFieldExtention(properties: widget.properties, validations: widget.validations, context: context);
  }
}

class ColorPickerInputFieldExtention extends FormField<Color> {
  ColorPickerInputFieldExtention({
    super.key,
    required ColorPickerPropertySchema properties,
    required ColorPickerInputValidationSchema validations,
    super.initialValue,
    super.onSaved,
    FormFieldValidator<Color>? validator,
    required BuildContext context,
  }) : super(
          validator: (value) {
            if (validations.required && value == null) {
              return validations.customErrorMessage ?? 'This field is required';
            }
            return validator != null ? validator(value) : null;
          },
          builder: (FormFieldState<Color> field) {
            final _ColorPickerInputFieldExtentionState state = field as _ColorPickerInputFieldExtentionState;

            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.h),
                  border: Border.all(
                    color: context.watch<ThemeBloc>().state.appColorTheme.gray90001,
                    width: 0.54.h,
                  ), // Background color for selected
                ),
              padding: EdgeInsets.all(4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(properties.label ?? ''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (field.value != null) 
                        Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: field.value,
                          borderRadius: BorderRadius.circular(15.h)
                        ),
                      ),
                      if (field.value != null) 
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ButtonStyle(
                              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 8.h
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                context.watch<ThemeBloc>().state.themeData.primaryColor,
                              ),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.h),
                                ),
                              ),
                              elevation: WidgetStateProperty.all<double>(0),
                              // visualDensity: WidgetStateProperty.all<VisualDensity>(
                              //   const VisualDensity(
                              //     vertical: -4,
                              //   ),
                              // ),
                            ),
                        onPressed: () async {
                          final pickedColor = await showDialog<Color>(
                            context: field.context,
                            useSafeArea: true,
                            builder: (context) => AlertDialog(
                              title: Text(properties.label ?? 'Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: field.value ?? Colors.green,
                                  onColorChanged: (color) => state.didChange(color),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text("Done"),
                                  onPressed: () {
                                    Navigator.of(context).pop(field.value);
                                  },
                                ),
                              ],
                            ),
                          );
                          if (pickedColor != null) {
                            state.didChange(pickedColor);
                          }
                          field.validate();
                        },
                        child:  Row(
                          children: [
                            SizedBox(width: 2.h,),
                            Icon(
                              Iconsax.colorfilter,
                              color: context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
                            ),
                            SizedBox(width: 2.h,),
                            Text(
                              'Click to Pick a Color',
                              style: TextStyle(
                                color: context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
                              ),
                              ),
                            SizedBox(width: 2.h,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (field.hasError) ...[
                    const SizedBox(height: 8),
                    Text(
                      field.errorText ?? '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            );
          },
        );

  @override
  FormFieldState<Color> createState() => _ColorPickerInputFieldExtentionState();
}

class _ColorPickerInputFieldExtentionState extends FormFieldState<Color> {
}

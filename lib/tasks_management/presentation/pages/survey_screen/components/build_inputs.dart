
import 'package:flutter/material.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/domain/questionTypes.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/audio_input_builder.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/checkbox_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/date_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/dropdown_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/email_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/file_media_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/radiobox_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/range_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/rating_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/signiture_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/slider_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/photo_taker.dart';

import '../../../../domain/inputPropertiesType.dart';
import '../../../../utils/enums/input_types.dart';
import 'inputTypes/color_picker.dart';
import 'inputTypes/later_media_input.dart';
import 'inputTypes/number_input.dart';
import 'inputTypes/text_input.dart';

List<Widget> buildInputs(BuildContext context, List<QuestionInput> inputs) {
  return List.generate(
    inputs.length, 
    (index) {

      final input = inputs[index];

      switch (input.inputType) {
        case InputTypesEnum.Media:
          if ((input.properties as MediaPropertySchema).mediaType.toLowerCase() == "image") {
            // return MediaInputField(properties: input.properties as MediaPropertySchema, validation: input.validationRules as MediaInputValidationSchema);
            return TakePhotoComponent(properties: input.properties as MediaPropertySchema, validations: input.validationRules as MediaInputValidationSchema);
          }
          if((input.properties as MediaPropertySchema).mediaType.toLowerCase() == "audio") {
            return AudioInputBuilder(property: input.properties as MediaPropertySchema, validation: input.validationRules as MediaInputValidationSchema);
          }
          
          return MediaFileInputField(properties: input.properties as MediaPropertySchema, validation: input.validationRules as MediaInputValidationSchema);
        case InputTypesEnum.Checkbox:
          return CheckboxInputField(properties: input.properties as CheckboxPropertySchema, validations: input.validationRules as CheckboxInputValidationSchema);
        case InputTypesEnum.ColorPicker:
          return ColorPickerInputField(properties: input.properties as ColorPickerPropertySchema, validations: input.validationRules as ColorPickerInputValidationSchema);
        case InputTypesEnum.Date:
          return DateInputField(properties: input.properties as DatePropertySchema, validations: input.validationRules as DateInputValidationSchema);
        case InputTypesEnum.Dropdown:
          return DropdownInputField(properties: input.properties as DropdownPropertySchema, validations: input.validationRules as DropdownInputValidationSchema);
        case InputTypesEnum.Email:
          return EmailInputField(properties: input.properties as EmailPropertySchema, validation: input.validationRules as EmailInputValidationSchema, );
        case InputTypesEnum.Number:
          return NumberInputField(properties: input.properties as NumberPropertySchema, validations: input.validationRules as NumberInputValidationSchema, );
        case InputTypesEnum.Radio:
          return RadioboxInputField(properties: input.properties as RadioPropertySchema, validations: input.validationRules as RadioInputValidationSchema);
        case InputTypesEnum.Range:
          return RangeInputField(properties: input.properties as RangePropertySchema, validations: input.validationRules as RangeInputValidationSchema);
        case InputTypesEnum.Rating:
          return RatingInputField(properties: input.properties as RatingPropertySchema, validations: input.validationRules as RatingInputValidationSchema);
        case InputTypesEnum.Slider:
          return SliderInputField(properties: input.properties as SliderPropertySchema, validations: input.validationRules as SliderInputValidationSchema);
        case InputTypesEnum.Text:
          return TextInputField(properties: input.properties as TextPropertySchema, validations: input.validationRules as TextInputValidationSchema, );
        case InputTypesEnum.Time:
          return RangeInputField(properties: input.properties as RangePropertySchema, validations: input.validationRules as RangeInputValidationSchema);
        case InputTypesEnum.Signature:
          return SketchFormField(properties: input.properties as SignaturePropertySchema, validations: input.validationRules as SignatureInputValidationSchema,);
        default:
          return const Placeholder();
      }
    },
    );
}
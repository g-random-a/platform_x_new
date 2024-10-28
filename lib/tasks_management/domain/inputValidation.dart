import 'package:platform_x/tasks_management/utils/enums/input_types.dart';

abstract class InputValidation {
  bool required;
  String? customErrorMessage;
  String? label;

  InputValidation({
    required this.required,
    this.customErrorMessage,
  });

  factory InputValidation.fromJson(Map<String, dynamic> json, InputTypesEnum type) {
    switch (type) {
      case InputTypesEnum.Text:
        return TextInputValidationSchema(
          required: json['isRequired'],
          maxLength: json['maxLength'],
          minLength: json['minLength'],
          regexPattern: json['regexPattern'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Email:
        return EmailInputValidationSchema(
          required: json['isRequired'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Password:
        return PasswordInputValidationSchema(
          required: json['isRequired'],
          minLength: json['minLength'],
          maxLength: json['maxLength'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Number:
        return NumberInputValidationSchema(
          required: json['isRequired'],
          min: json['min'],
          max: json['max'],
          allowDecimal: json['allowDecimal'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Date:
        return DateInputValidationSchema(
          required: json['isRequired'],
          minDate: json['minDate'],
          maxDate: json['maxDate'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Time:
        return TimeInputValidationSchema(
          required: json['isRequired'],
          minTime: json['minTime'],
          maxTime: json['maxTime'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Tel:
        return TelInputValidationSchema(
          required: json['isRequired'],
          minLength: json['minLength'],
          maxLength: json['maxLength'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Checkbox:
        return CheckboxInputValidationSchema(
          required: json['isRequired'],
          customErrorMessage: json['customErrorMessage'],
          maxSelection: json['maxSelection'],
          minSelection: json['minSelection'],
        );
      case InputTypesEnum.Radio:
        return RadioInputValidationSchema(
          required: json['isRequired'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Dropdown:
        return DropdownInputValidationSchema(
          required: json['isRequired'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Range:
        return RangeInputValidationSchema(
          required: json['isRequired'],
          minValue: json['minValue'],
          maxValue: json['maxValue'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Signature:
        return SignatureInputValidationSchema(
          required: json['isRequired'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Media:
        return MediaInputValidationSchema(
          required: json['isRequired'],
          acceptedFormats: json['acceptedFormats'].map<String>((format) => format.toString()).toList(),
          maxFileSize: json['maxFileSize'],
          customErrorMessage: json['customErrorMessage'],
          multiple: json['multiple'],
          mediaType: json['mediaType'],
          numberOfFiles: json['numberOfFiles'],
        );
      case InputTypesEnum.ColorPicker:
        return ColorPickerInputValidationSchema(
          required: json['isRequired'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Matrix:
        return MatrixInputValidationSchema(
          required: json['isRequired'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Slider:
        return SliderInputValidationSchema(
          required: json['isRequired'],
          minValue: json['minValue'],
          maxValue: json['maxValue'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Canvas:
        return CanvasInputValidationSchema(
          required: json['isRequired'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.RichText:
        return RichTextInputValidationSchema(
          required: json['isRequired'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Location:
        return LocationInputValidationSchema(
          required: json['isRequired'],
          customErrorMessage: json['customErrorMessage'],
        );
      case InputTypesEnum.Rating:
        return RatingInputValidationSchema(
          required: json['isRequired'],
          minRating: json['minRating'],
          maxRating: json['maxRating'],
          customErrorMessage: json['customErrorMessage'],
        );
      default:
        throw Exception('Invalid input type');      
    }
  }
}

class TextInputValidationSchema extends InputValidation {
  int? maxLength;
  int? minLength;
  String? regexPattern;

  TextInputValidationSchema({
    required super.required,
    this.maxLength,
    this.minLength,
    this.regexPattern,
    super.customErrorMessage,
  });
}

class EmailInputValidationSchema extends InputValidation {
  EmailInputValidationSchema({
    required super.required,
    super.customErrorMessage,
  });
}

class PasswordInputValidationSchema extends InputValidation {
  int? minLength;
  int? maxLength;

  PasswordInputValidationSchema({
    required super.required,
    this.minLength,
    this.maxLength,
    super.customErrorMessage,
  });
}

class NumberInputValidationSchema extends InputValidation {
  int? min;
  int? max;
  bool? allowDecimal;

  NumberInputValidationSchema({
    required super.required,
    this.min,
    this.max,
    this.allowDecimal,
    super.customErrorMessage,
  });
}

class DateInputValidationSchema extends InputValidation {
  String? minDate;
  String? maxDate;

  DateInputValidationSchema({
    required super.required,
    this.minDate,
    this.maxDate,
    super.customErrorMessage,
  });
}

class TimeInputValidationSchema extends InputValidation {
  String? minTime;
  String? maxTime;

  TimeInputValidationSchema({
    required super.required,
    this.minTime,
    this.maxTime,
    super.customErrorMessage,
  });
}

class TelInputValidationSchema extends InputValidation {
  int? minLength;
  int? maxLength;

  TelInputValidationSchema({
    required super.required,
    this.minLength,
    this.maxLength,
    super.customErrorMessage,
  });
}

class CheckboxInputValidationSchema extends InputValidation {
  int? minSelection;
  int? maxSelection;

  CheckboxInputValidationSchema({
    required super.required,
    super.customErrorMessage,
    this.maxSelection,
    this.minSelection,
  });
}

class RadioInputValidationSchema extends InputValidation {
  RadioInputValidationSchema({
    required super.required,
    super.customErrorMessage,
  });
}

class DropdownInputValidationSchema extends InputValidation {
  DropdownInputValidationSchema({
    required super.required,
    super.customErrorMessage,
  });
}

class RangeInputValidationSchema extends InputValidation {
  int? minValue;
  int? maxValue;

  RangeInputValidationSchema({
    required super.required,
    this.minValue,
    this.maxValue,
    super.customErrorMessage,
  });
}

class SignatureInputValidationSchema extends InputValidation {
  SignatureInputValidationSchema({
    required super.required,
    super.customErrorMessage,
  });
}

class MediaInputValidationSchema extends InputValidation {
  List<String>? acceptedFormats;
  int? maxFileSize;
  bool? multiple;
  int? numberOfFiles;
  String? mediaType;

  MediaInputValidationSchema({
    required super.required,
    this.acceptedFormats,
    this.maxFileSize,
    super.customErrorMessage,
    this.multiple,
    this.numberOfFiles,
    this.mediaType,
  });
}

class ColorPickerInputValidationSchema extends InputValidation {
  ColorPickerInputValidationSchema({
    required super.required,
    super.customErrorMessage,
  });
}

class MatrixInputValidationSchema extends InputValidation {
  MatrixInputValidationSchema({
    required super.required,
    super.customErrorMessage,
  });
}

class SliderInputValidationSchema extends InputValidation {
  int? minValue;
  int? maxValue;

  SliderInputValidationSchema({
    required super.required,
    this.minValue,
    this.maxValue,
    super.customErrorMessage,
  });
}

class CanvasInputValidationSchema extends InputValidation {
  CanvasInputValidationSchema({
    required super.required,
    super.customErrorMessage,
  });
}

class RichTextInputValidationSchema extends InputValidation {
  RichTextInputValidationSchema({
    required super.required,
    super.customErrorMessage,
  });
}

class LocationInputValidationSchema extends InputValidation {
  LocationInputValidationSchema({
    required super.required,
    super.customErrorMessage,
  });
}

class RatingInputValidationSchema extends InputValidation {
  int? minRating;
  int? maxRating;

  RatingInputValidationSchema({
    required super.required,
    this.minRating,
    this.maxRating,
    super.customErrorMessage,
  });
}

// Union type for all validation rules
typedef ValidationRules = InputValidation;

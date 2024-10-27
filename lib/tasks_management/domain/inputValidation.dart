abstract class InputValidation {
  bool required;
  String? customErrorMessage;
  String? label;

  InputValidation({
    required this.required,
    this.customErrorMessage,
  });
}

class TextInputValidationSchema extends InputValidation {
  int? maxLength;
  int? minLength;
  String? regexPattern;

  TextInputValidationSchema({
    required bool required,
    this.maxLength,
    this.minLength,
    this.regexPattern,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class EmailInputValidationSchema extends InputValidation {
  EmailInputValidationSchema({
    required bool required,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class PasswordInputValidationSchema extends InputValidation {
  int? minLength;
  int? maxLength;

  PasswordInputValidationSchema({
    required bool required,
    this.minLength,
    this.maxLength,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class NumberInputValidationSchema extends InputValidation {
  int? min;
  int? max;
  bool? allowDecimal;

  NumberInputValidationSchema({
    required bool required,
    this.min,
    this.max,
    this.allowDecimal,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class DateInputValidationSchema extends InputValidation {
  String? minDate;
  String? maxDate;

  DateInputValidationSchema({
    required bool required,
    this.minDate,
    this.maxDate,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class TimeInputValidationSchema extends InputValidation {
  String? minTime;
  String? maxTime;

  TimeInputValidationSchema({
    required bool required,
    this.minTime,
    this.maxTime,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class TelInputValidationSchema extends InputValidation {
  int? minLength;
  int? maxLength;

  TelInputValidationSchema({
    required bool required,
    this.minLength,
    this.maxLength,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class CheckboxInputValidationSchema extends InputValidation {
  CheckboxInputValidationSchema({
    required bool required,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class RadioInputValidationSchema extends InputValidation {
  RadioInputValidationSchema({
    required bool required,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class DropdownInputValidationSchema extends InputValidation {
  DropdownInputValidationSchema({
    required bool required,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class RangeInputValidationSchema extends InputValidation {
  int? minValue;
  int? maxValue;

  RangeInputValidationSchema({
    required bool required,
    this.minValue,
    this.maxValue,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class SignatureInputValidationSchema extends InputValidation {
  SignatureInputValidationSchema({
    required bool required,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class MediaInputValidationSchema extends InputValidation {
  List<String>? acceptedFormats;
  int? maxFileSize;

  MediaInputValidationSchema({
    required bool required,
    this.acceptedFormats,
    this.maxFileSize,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class ColorPickerInputValidationSchema extends InputValidation {
  ColorPickerInputValidationSchema({
    required bool required,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class MatrixInputValidationSchema extends InputValidation {
  MatrixInputValidationSchema({
    required bool required,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class SliderInputValidationSchema extends InputValidation {
  int? minValue;
  int? maxValue;

  SliderInputValidationSchema({
    required bool required,
    this.minValue,
    this.maxValue,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class CanvasInputValidationSchema extends InputValidation {
  CanvasInputValidationSchema({
    required bool required,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class RichTextInputValidationSchema extends InputValidation {
  RichTextInputValidationSchema({
    required bool required,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class LocationInputValidationSchema extends InputValidation {
  LocationInputValidationSchema({
    required bool required,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

class RatingInputValidationSchema extends InputValidation {
  int minRating;
  int maxRating;

  RatingInputValidationSchema({
    required bool required,
    required this.minRating,
    required this.maxRating,
    String? customErrorMessage,
  }) : super(required: required, customErrorMessage: customErrorMessage);
}

// Union type for all validation rules
typedef ValidationRules = InputValidation;

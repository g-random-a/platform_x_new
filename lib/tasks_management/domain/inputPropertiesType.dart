import 'package:platform_x/tasks_management/utils/enums/input_types.dart';

abstract class InputProperties {
  String? label;
  String? suffix;

  InputProperties({
     this.label,
     this.suffix
  });

  factory InputProperties.fromJson(Map<String, dynamic> json, InputTypesEnum type){

    switch(type) {
      case InputTypesEnum.Text:
        return TextPropertySchema(
          placeholder: json['placeholder'],
          defaultValue: json['defaultValue'],
          label: json['label'],
          suffix: json['suffix'],
          multiLine: json['multiLine'],
          lines: json['lines'],
        );
      case InputTypesEnum.Email:
        return EmailPropertySchema(
          placeholder: json['placeholder'],
          defaultValue: json['defaultValue'],
          label: json['label'],
          suffix: json['suffix'],
        );
      case InputTypesEnum.Password:
        return PasswordPropertySchema(
          placeholder: json['placeholder'],
          defaultValue: json['defaultValue'],
          label: json['label'],
        );
      case InputTypesEnum.Number:
        return NumberPropertySchema(
          placeholder: json['placeholder'],
          defaultValue: json['defaultValue'],
          label: json['label'],
          suffix: json['suffix'],
          step: json['step'],
        );
      case InputTypesEnum.Date:
        return DatePropertySchema(
          placeholder: json['placeholder'],
          defaultValue: json['defaultValue'],
          label: json['label'],
          minDate: json['minDate'],
          maxDate: json['maxDate'],
        );
      case InputTypesEnum.Time:
        return TimePropertySchema(
          placeholder: json['placeholder'],
          defaultValue: json['defaultValue'],
          label: json['label'],
        );
      case InputTypesEnum.Tel:
        return TelPropertySchema(
          placeholder: json['placeholder'],
          defaultValue: json['defaultValue'],
          label: json['label'],
        );
      case InputTypesEnum.Checkbox: 
        return CheckboxPropertySchema(
          type: json['type'],
          options: (json['options'] as List).map((option) => InputOptions.fromJson(option)).toList() ?? [],
          label: json['label'],
        );
      case InputTypesEnum.Radio:  
        return RadioPropertySchema(
          options: (json['options'] as List).map((option) => InputOptions.fromJson(option)).toList() ?? [],
          defaultValue: json['defaultValue'],
          label: json['label'],
        );
      case InputTypesEnum.Dropdown: 
        return DropdownPropertySchema(
          options: (json['options'] as List).map((option) => InputOptions.fromJson(option)).toList() ?? [],
          defaultValue: json['defaultValue'],
          placeholder: json['placeholder'],
          label: json['label'],
        );
      case InputTypesEnum.Range:
        return RangePropertySchema(
          min: json['min'],
          max: json['max'],
          step: json['step'],
          defaultMin: json['defaultMin'],
          defaultMax: json['defaultMax'],
          label: json['label'],
        );
      case InputTypesEnum.Signature:
        return SignaturePropertySchema(
          label: json['label'],
        );
      case InputTypesEnum.Media:
        return MediaPropertySchema(
          mediaType: json['mediaType'],
          multiple: json['multiple'],
          label: json['label'],
        );
      case InputTypesEnum.ColorPicker:
        return ColorPickerPropertySchema(
          label: json['label'],
        );
      case InputTypesEnum.Matrix:
        return MatrixPropertySchema(
          rows: json['rows'],
          columns: json['columns'],
          label: json['label'],
        );
      case InputTypesEnum.Slider:
        return SliderPropertySchema(
          min: json['startValue'],
          max: json['endValue'],
          step: json['step'],
          defaultValue: json['defaultValue'],
          label: json['label'],
        );
      case InputTypesEnum.RichText:
        return RichTextPropertySchema(
          label: json['label'],
        );
      case InputTypesEnum.Location: 
        return LocationPropertySchema(
          placeholder: json['placeholder'],
          defaultValue: json['defaultValue'],
          label: json['label'],
        );
      case InputTypesEnum.Rating:
        return RatingPropertySchema(
          defaultValue: json['defaultValue']?.toDouble(),
          minimumRating: json['minimumRating']?.toDouble(),
          maximumRating: json['maximumRating']?.toDouble(),
          defaultRating: json['defaultRating']?.toDouble(),
          icon: json['icon'],
          label: json['label'],
        );
      default:
        throw Exception('Invalid Input Type');
    }
  }
}

class TextPropertySchema extends InputProperties {
  String? placeholder;
  String? defaultValue;
  bool? multiLine;
  int? lines;

  TextPropertySchema({
    this.placeholder,
    this.defaultValue, 
    super.label,
    super.suffix,
    this.multiLine,
    this.lines,
  });
}

class EmailPropertySchema extends InputProperties {
  String? placeholder;
  String? defaultValue;
  @override
  String? suffix;


  EmailPropertySchema({
    this.placeholder,
    this.defaultValue,
    this.suffix, 
    super.label,
  });
}

class PasswordPropertySchema extends InputProperties {
  String? placeholder;
  String? defaultValue;

  PasswordPropertySchema({
    this.placeholder,
    this.defaultValue,
    super.label,
  });
}

class NumberPropertySchema extends InputProperties {
  String? placeholder;
  int? defaultValue;
  int? step;
  @override
  String? suffix;

  NumberPropertySchema({
    this.placeholder,
    this.defaultValue,
    super.label,
    this.step,
    this.suffix
  });
}

class DatePropertySchema extends InputProperties {
  String? placeholder;
  String? defaultValue;
  String? minDate;
  String? maxDate;

  DatePropertySchema({
    this.placeholder,
    this.defaultValue,
    this.minDate,
    this.maxDate,
    super.label
  });
}

class TimePropertySchema extends InputProperties {
  String? placeholder;
  String? defaultValue;

  TimePropertySchema({
    this.placeholder,
    this.defaultValue,
    super.label
  });
}

class TelPropertySchema extends InputProperties {
  String? placeholder;
  String? defaultValue;

  TelPropertySchema({
    this.placeholder,
    this.defaultValue,
    super.label
  });
}

class InputOptions {
  int id;
  String valueType;
  String value;
  bool selected = false;

  InputOptions({required this.id, required this.value, required this.valueType});


  factory InputOptions.fromJson(Map<String, dynamic> json) {
    return InputOptions(
      id: json['id'],
      value: json['value'], 
      valueType: json['valueType'],
      );
  }
}


class CheckboxPropertySchema extends InputProperties {
  String? type;
  List<InputOptions> options;

  CheckboxPropertySchema({
    required this.type,
    required this.options,
    super.label
  });
}

class RadioPropertySchema extends InputProperties {
  List<InputOptions> options;
  String? defaultValue;

  RadioPropertySchema({
    required this.options,
    this.defaultValue,
    super.label
  });
}

class DropdownPropertySchema extends InputProperties {
  List<InputOptions> options;
  String? defaultValue;
  String? placeholder;

  DropdownPropertySchema({
    required this.options,
    this.defaultValue,
    this.placeholder,
    super.label
  });
}

class RangePropertySchema extends InputProperties {
  int min;
  int max;
  int? step;
  int? defaultMin;
  int? defaultMax;

  RangePropertySchema({
    required this.min,
    required this.max,
    this.step,
    this.defaultMin,
    this.defaultMax,
    super.label
  });
}

class SignaturePropertySchema extends InputProperties {

  SignaturePropertySchema({super.label});

}

class MediaPropertySchema extends InputProperties {
  String mediaType; // Use an appropriate enum or class for mediaType
  bool? multiple;

  MediaPropertySchema({
    required this.mediaType,
    this.multiple,
    super.label
  });
}

class ColorPickerPropertySchema extends InputProperties {
  ColorPickerPropertySchema({super.label});
}

class MatrixPropertySchema extends InputProperties {
  List<String> rows;
  List<String> columns;

  MatrixPropertySchema({
    required this.rows,
    required this.columns, super.label,
  });
}

class SliderPropertySchema extends InputProperties {
  int min;
  int max;
  int? step;
  int? defaultValue;

  SliderPropertySchema({
    required this.min,
    required this.max,
    this.step,
    this.defaultValue, super.label,
  });
}

class RichTextPropertySchema extends InputProperties {

  RichTextPropertySchema({super.label});
}

class LocationPropertySchema extends InputProperties {
  String? placeholder;
  String? defaultValue;

  LocationPropertySchema({
    this.placeholder,
    this.defaultValue, super.label,
  });
}

class RatingPropertySchema extends InputProperties {
  double? defaultValue;
  double minimumRating;
  double maximumRating;
  double? defaultRating;
  String? icon;

  RatingPropertySchema({
    this.defaultRating,
    this.defaultValue,
    required this.maximumRating,
    required this.minimumRating, super.label,
    this.icon
  });
}

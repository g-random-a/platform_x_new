abstract class InputProperties {
  String? label;
  String? suffix;

  InputProperties({
     this.label,
     this.suffix
  });
}

class TextPropertySchema extends InputProperties {
  String? placeholder;
  String? defaultValue;
  String? suffix;
  bool? multiLine;
  int? lines;

  TextPropertySchema({
    this.placeholder,
    this.defaultValue, 
    super.label,
    this.suffix,
    this.multiLine,
    this.lines,
  });
}

class EmailPropertySchema extends InputProperties {
  String? placeholder;
  String? defaultValue;
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

class CheckboxPropertySchema extends InputProperties {
  String type;
  List<Map<String, Object>> values;

  CheckboxPropertySchema({
    required this.type,
    required this.values,
    super.label
  });
}

class RadioPropertySchema extends InputProperties {
  List<Map<String, Object>> options;
  String? defaultValue;

  RadioPropertySchema({
    required this.options,
    this.defaultValue,
    super.label
  });
}

class DropdownPropertySchema extends InputProperties {
  List<String> options;
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

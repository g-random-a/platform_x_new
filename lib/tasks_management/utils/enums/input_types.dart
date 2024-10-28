// ignore_for_file: constant_identifier_names

enum InputTypesEnum {
  Text,
  Email,
  Password,
  Number,
  Date,
  DatetimeLocal,
  Month,
  Week,
  Time,
  Tel,
  Checkbox,
  Radio,
  Dropdown,
  Range,
  Signature,
  Media,
  ColorPicker,
  Matrix,
  Slider,
  Canvas,
  RichText,
  Location,
  Rating,
}


InputTypesEnum parseInputType(String type) {
  print(type);
  switch (type.toLowerCase()) {
    case 'text':
      return InputTypesEnum.Text;
    case 'email':
      return InputTypesEnum.Email;
    case 'password':
      return InputTypesEnum.Password;
    case 'number':
      return InputTypesEnum.Number;
    case 'date':
      return InputTypesEnum.Date;
    case 'datetimelocal':
      return InputTypesEnum.DatetimeLocal;
    case 'month':
      return InputTypesEnum.Month;
    case 'week':
      return InputTypesEnum.Week;
    case 'time':
      return InputTypesEnum.Time;
    case 'tel':
      return InputTypesEnum.Tel;
    case 'checkbox':
      return InputTypesEnum.Checkbox;
    case 'radio':
      return InputTypesEnum.Radio;
    case 'dropdown':
      return InputTypesEnum.Dropdown;
    case 'range':
      return InputTypesEnum.Range;
    case 'signature':
      return InputTypesEnum.Signature;
    case 'media':
      return InputTypesEnum.Media;
    case 'colorpicker':
      return InputTypesEnum.ColorPicker;
    case 'matrix':
      return InputTypesEnum.Matrix;
    case 'slider':
      return InputTypesEnum.Slider;
    case 'canvas':
      return InputTypesEnum.Canvas;
    case 'richtext':
      return InputTypesEnum.RichText;
    case 'location':
      return InputTypesEnum.Location;
    case 'rating':
      return InputTypesEnum.Rating;
    default:
      // throw Exception('Unknown input type: $type');
      return InputTypesEnum.Text;
  }
}

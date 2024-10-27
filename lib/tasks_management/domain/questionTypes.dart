import '../utils/enums/input_types.dart';
import 'file_type.dart';
import 'inputPropertiesType.dart';
import 'inputValidation.dart';

class IQuestion {
  String? id;
  String taskId;
  String text;
  List<File>? files;
  List<QuestionInput> inputs;
  DateTime? createdAt;
  DateTime? updatedAt;

  IQuestion({
    this.id,
    required this.taskId,
    required this.text,
    this.files,
    required this.inputs,
    this.createdAt,
    this.updatedAt,
  });
}

class QuestionInput {
  int id;
  InputTypesEnum inputType;
  ValidationRules validationRules;
  InputProperties properties;

  QuestionInput({
    required this.id,
    required this.inputType,
    required this.validationRules,
    required this.properties,
  });
}

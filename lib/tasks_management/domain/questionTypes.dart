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

  factory IQuestion.fromJson(Map<String, dynamic> json) {

    print("decoding question");

  IQuestion question =  IQuestion(
    id: json['_id'],
    taskId: json['taskId'],
    text: json['text'],
    createdAt: DateTime.tryParse(json['createdAt']),
    updatedAt: DateTime.tryParse(json['updatedAt']),
    files: json['files']?.map<File>((file) => File.fromJson(file)).toList(),
    inputs: json['inputs'].map<QuestionInput>((input) => QuestionInput.fromJson(input)).toList(),
  );

  return question;
}

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

  factory QuestionInput.fromJson(Map<String, dynamic> json) {
    QuestionInput input = QuestionInput(
      id: json['id'],
      inputType: parseInputType(json['inputType']),
      validationRules: ValidationRules.fromJson(json['validationRules'],  parseInputType(json['inputType'])),
      properties: InputProperties.fromJson(json['properties'],  parseInputType(json['inputType'])),
    );

    return input;
  }


}

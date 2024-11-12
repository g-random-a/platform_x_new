import 'package:hive/hive.dart';

part 'answerType.g.dart';

// Base Answer Class Interface
abstract class IAnswer {
  int get id;
}

// TEXT, EMAIL, NUMBER, DATE, TIME, COLORPICKER, SLIDER, LOCATION, RATING Answer
@HiveType(typeId: 2)
class ValueAnswer extends IAnswer {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String value;

  ValueAnswer({required this.id, required this.value});
}

@HiveType(typeId: 7)
class InputOptions {

  @HiveField(0)
  int id;

  @HiveField(1)
  String value;

  @HiveField(2)
  String valueType;
  
  @HiveField(3)
  bool selected = false;

  InputOptions({required this.id, required this.value, required this.valueType});

  factory InputOptions.fromJson(Map<String, dynamic> json) {
    return InputOptions(
      id: json['id'],
      value: json['value'], 
      valueType: json['valueType'],
      );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InputOptions &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

// MULTIPLE_CHOICE/CHECKBOX, DROPDOWN, RADIOBUTTON Answer
@HiveType(typeId: 3)
class SelectionAnswer extends IAnswer {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final List<InputOptions> selected;

  SelectionAnswer({required this.id, required this.selected});
}

// Range Answer
@HiveType(typeId: 4)
class RangeAnswer extends IAnswer {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final num startValue;

  @HiveField(2)
  final num endValue;

  RangeAnswer({
    required this.id,
    required this.startValue,
    required this.endValue,
  });
}

// FILE/Media Input Answer
@HiveType(typeId: 5)
class FileAnswer extends IAnswer {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final List<dynamic> file; // Use a specific type if possible

  FileAnswer({required this.id, required this.file});
}

// Main Answer Format Class
@HiveType(typeId: 6)
class AnswerFormat extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String questionId;

  @HiveField(2)
  final List<IAnswer> answers;

  AnswerFormat({
    required this.userId,
    required this.questionId,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'questionId': questionId,
      'answers': answers.map((answer) {
        if (answer is ValueAnswer) {
          return {
            'id': answer.id,
            'value': answer.value,
          };
        } else if (answer is SelectionAnswer) {
          return {
            'id': answer.id,
            'selected': answer.selected,
          };
        } else if (answer is RangeAnswer) {
          return {
            'id': answer.id,
            'startValue': answer.startValue,
            'endValue': answer.endValue,
          };
        } else if (answer is FileAnswer) {
          return {
            'id': answer.id,
            'file': answer.file,
          };
        }
        return {};
      }).toList(),
    };
  }

  // Function to convert the JSON-like Map to a class
  factory AnswerFormat.fromJson(Map<String, dynamic> json) {
    return AnswerFormat(
      userId: json['userId'],
      questionId: json['questionId'],
      answers: (json['answers'] as List).map<IAnswer>((answer) {
        if (answer['value'] != null) {
          return ValueAnswer(id: answer['id'], value: answer['value']);
        } else if (answer['selected'] != null) {
          return SelectionAnswer(id: answer['id'], selected: answer['selected']);
        } else if (answer['startValue'] != null) {
          return RangeAnswer(
            id: answer['id'],
            startValue: answer['startValue'],
            endValue: answer['endValue'],
          );
        } else if (answer['file'] != null) {
          return FileAnswer(id: answer['id'], file: answer['file']);
        }
        throw Exception('Unknown answer type');
      }).toList(),
    );
  }
}

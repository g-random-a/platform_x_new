// Base Answer Class
class IAnswer {
  final int id;

  IAnswer({required this.id});
}

// TEXT, EMAIL, NUMBER, DATE, TIME, COLORPICKER, SLIDER, LOCATION, RATING Answer
class ValueAnswer extends IAnswer {
  final String value;

  ValueAnswer({required int id, required this.value}) : super(id: id);
}

// MULTIPLE_CHOICE/CHECKBOX, DROPDOWN, RADIOBUTTON Answer
class SelectionAnswer extends IAnswer {
  final List<int> selected;

  SelectionAnswer({required int id, required this.selected}) : super(id: id);
}

// Range Answer
class RangeAnswer extends IAnswer {
  final num startValue;
  final num endValue;

  RangeAnswer({
    required int id,
    required this.startValue,
    required this.endValue,
  }) : super(id: id);
}

// FILE/Media Input Answer
class FileAnswer extends IAnswer {
  final List<dynamic> file; // Change 'dynamic' to a specific file type if needed

  FileAnswer({required int id, required this.file}) : super(id: id);
}

// Main Answer Format Class
class AnswerFormat {
  final String userId;
  final String questionId;
  final List<IAnswer> answers;

  AnswerFormat({
    required this.userId,
    required this.questionId,
    required this.answers,
  });

  // Function to convert the class to a JSON-like Map
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
      answers: (json['answers'] as List).map((answer) {
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
        return IAnswer(id: answer['id']);
      }).toList(),
    );
  }
}

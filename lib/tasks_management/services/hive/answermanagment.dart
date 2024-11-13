import 'package:hive_flutter/hive_flutter.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';

class AnswerManagement {
  late Box<AnswerFormat> _answerBox;

  Future<void> init() async {

    await Hive.initFlutter(); 
    
    Hive.registerAdapter(InputOptionsAdapter());
    Hive.registerAdapter(ValueAnswerAdapter());
    Hive.registerAdapter(SelectionAnswerAdapter());
    Hive.registerAdapter(RangeAnswerAdapter());
    Hive.registerAdapter(FileAnswerAdapter());
    Hive.registerAdapter(AnswerFormatAdapter());

    _answerBox = await Hive.openBox<AnswerFormat>('answers');
  }

  Future<void> addOrUpdateAnswer(AnswerFormat answer) async {
    await _answerBox.put(answer.questionId, answer);
  }

  AnswerFormat? getAnswerByQuestionId(String questionId) {
    return _answerBox.get(questionId);
  }

  List<AnswerFormat> getAllAnswers() {
    return _answerBox.values.toList();
  }

  Future<void> deleteAnswer(String questionId) async {
    await _answerBox.delete(questionId);
  }

  Future<void> close() async {
    await _answerBox.close();
  }

  Future<void> deleteAnswers(List<String> questionIds) async {
    for (var questionId in questionIds) {
      await _answerBox.delete(questionId);
    }
  }
}

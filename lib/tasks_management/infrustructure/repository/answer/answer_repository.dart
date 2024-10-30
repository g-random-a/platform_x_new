

import '../../../domain/questionTypes.dart';
import '../../data_provider/question/question_data_provider.dart';

class QuestionsRepository {
  final QuestionsDataProvider tasksDataProvider;

  QuestionsRepository({required this.tasksDataProvider});

  // Future<bool> submitIQuestion(IQuestion task) async {
  //   try {
  //     bool isQuestionsSent = await tasksDataProvider.submitIQuestion(task);
  //     return isQuestionsSent;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<List<IQuestion>> loadQuestions(String taskId) async {
    try {
      List<IQuestion> tasks = await tasksDataProvider.loadQuestions(taskId);
      return tasks;
    } catch (e) {
      rethrow;
    }
  }
}
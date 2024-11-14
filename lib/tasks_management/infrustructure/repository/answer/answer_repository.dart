
import '../../../domain/answerType.dart';
import '../../data_provider/answer/answer_data_provider.dart';

class AnswerRepository {
  final AnswerDataProvider answerDataProvider;

  AnswerRepository({required this.answerDataProvider});

  Future<bool> submitAnswer(List<AnswerFormat> answers, String taskId, double taskBudget) async {
    try {
      bool isAnswerSent = await answerDataProvider.submitAnswer(answers, taskId, taskBudget);
      return isAnswerSent;
    } catch (e) {
      rethrow;
    }
  }

}
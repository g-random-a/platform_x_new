
import '../../../domain/answerType.dart';
import '../../data_provider/answer/answer_data_provider.dart';

class AnswerRepository {
  final AnswerDataProvider answerDataProvider;

  AnswerRepository({required this.answerDataProvider});

  Future<bool> submitAnswer(List<AnswerFormat> answers, String taskId) async {
    try {
      bool isAnswerSent = await answerDataProvider.submitAnswer(answers, taskId);
      return isAnswerSent;
    } catch (e) {
      rethrow;
    }
  }

}
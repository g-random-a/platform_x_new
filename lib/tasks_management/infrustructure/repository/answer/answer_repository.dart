
import '../../../domain/answerType.dart';
import '../../data_provider/answer/answer_data_provider.dart';

class AnswerRepository {
  final AnswerDataProvider answerDataProvider;

  AnswerRepository({required this.answerDataProvider});

  Future<bool> submitAnswer(Map<String, Map<String, IAnswer>> answers) async {
    try {
      bool isAnswerSent = await answerDataProvider.submitAnswer(answers);
      return isAnswerSent;
    } catch (e) {
      rethrow;
    }
  }

}
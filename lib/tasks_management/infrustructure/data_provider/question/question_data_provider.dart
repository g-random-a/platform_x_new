import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/domain/questionTypes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data_provider.dart';

class QuestionsDataProvider extends DataProvider {
  final Dio dio;

  QuestionsDataProvider({required this.dio});

  // Future<bool> submitQuestion(IQuestion feedback) async {
  //   try {
  //     FormData formData = FormData.fromMap(feedback.toJson());
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('token');
  //     if (token == null) {
  //       throw Exception("notLogged In");
  //     }
  //     dio.options.headers['content-Type'] = 'application/json';
  //     dio.options.headers['cookie'] = 'session=$token';

  //     Response response = await dio.post("/submit_question/", data: formData);

  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       throw Exception("Error while sending feedback.");
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<List<IQuestion>> loadQuestions(String taskId) async {
    try {

      dio.options.headers['content-Type'] = 'application/json';

      Response response = await dio.get("/v1/task/$taskId/questions/");

      if (response.statusCode != 200) {
        throw Exception("Error while loading questions.");
      }

      List<IQuestion> questions = [];

      print("------------------------------------------------------");
      print(taskId);
      print(response.data);

      List forms = response.data['data'];

      for (var form in forms) {
        // print(form.runtimeType);
        print(form);

        IQuestion question = IQuestion.fromJson(form);
        
        questions.add(question);
      }
      
      return questions;

    } catch (e) {
      print("@Error: $e",);
      rethrow;
    }

  }

}
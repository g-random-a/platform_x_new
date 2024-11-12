import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/data_provider.dart';


class AnswerDataProvider extends DataProvider {
  final Dio dio;

  AnswerDataProvider({required this.dio});

  Future<bool> submitAnswer(Map<String, Map<String, IAnswer>> answers) async {
    try {

      // open storage and get userid
      final storage = await SharedPreferences.getInstance();
      final userId = storage.getString("userId");

      if (userId == null) {
        throw Exception("User not logged in.");
      }

      dio.options.headers['Content-Type'] = 'multipart/form-data';

      FormData formData = FormData();

      answers.forEach((questionId, allAnswers) async {
        Map<String, dynamic> answerData = {
          "questionId": questionId,
          "userId": userId,
          "answers": []
        };

        allAnswers.forEach((answerId, answer) async {
          if (answer is ValueAnswer) {
            answerData["answers"].add({
              "id": answer.id,
              "value": answer.value,
            });
          } else if (answer is SelectionAnswer) {
            answerData["answers"].add({
              "id": answer.id,
              "selected": answer.selected,
            });
          } else if (answer is RangeAnswer) {
            answerData["answers"].add({
              "id": answer.id,
              "startValue": answer.startValue,
              "endValue": answer.endValue,
            });
          } else if (answer is FileAnswer) {
            List<MultipartFile> files = await Future.wait(answer.file.map((filePath) async {
              return await MultipartFile.fromFile(
                filePath,
                filename: filePath.split('/').last,
              );
            }).toList());

            formData.files.addAll(
                files.map((file) => MapEntry("file", file))); 
            answerData["answers"].add({"id": answer.id, "file": [...answer.file]}); 
          };
        });

      });

      Response response = await dio.post(
        "/v1/answer/",
        data: formData,
      );

      if (response.statusCode != 201) {
        throw Exception("Error while submitting answers.");
      }

      return true;
    } catch (e) {
      print("@Error: $e");
      rethrow;
    }
  }

}

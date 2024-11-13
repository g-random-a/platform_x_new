import 'dart:convert';

import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/data_provider.dart';


class AnswerDataProvider extends DataProvider {
  final Dio dio;

  AnswerDataProvider({required this.dio});

  Future<bool> submitAnswer(List<AnswerFormat> answers, String taskId) async {
    try {

      SharedPreferences _pref = await SharedPreferences.getInstance();
      String userId = _pref.getString("user_id") ?? '';

      dio.options.headers['Content-Type'] = 'multipart/form-data';
      List<Map<String, dynamic>> finalAnswers = [];

      answers.forEach(
        (ans) async {
          finalAnswers.add(ans.toJson(taskId));
        }
      );

      FormData formData = FormData.fromMap({
        'data': finalAnswers,
      });;


      answers.forEach(
        (currentAns) async {
          var answer = currentAns.answers[0];
          if (answer is FileAnswer) {
            List<MultipartFile> files = await Future.wait(answer.file.map((filePath) async {
              return await MultipartFile.fromFile(
                filePath,
                filename: filePath.split('/').last,
              );
            }).toList());

            formData.files.addAll(
                files.map((file) => MapEntry("file", file))); 
          };
        }
      );




      print("-----------------------------------");
      print(finalAnswers);
      print("-----------------------------------");


      String formAns = jsonEncode(finalAnswers);

      print("-----------------------------------");
      print(formAns);
      print("-----------------------------------");

      formData.fields.add(MapEntry("answer", formAns));

      Response response = await dio.post(
        "/v1/response/",
        data: formData,
      );

      if (response.statusCode != 201) {
        throw Exception("Error while submitting answers.");
      }

      Response userTaskResp = await dio.post("/v1/task/users", data: {
        userId, taskId
      });

      if (userTaskResp != 200) {
        throw Exception("Error while creating userTask...");
      }

      return true;
    } catch (e) {
      print("@Error: $e");
      rethrow;
    }
  }

}

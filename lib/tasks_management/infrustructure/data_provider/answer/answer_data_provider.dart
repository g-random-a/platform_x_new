import 'dart:convert';

import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/data_provider.dart';


class AnswerDataProvider extends DataProvider {
  final Dio dio; 

  AnswerDataProvider({required this.dio});

  Future<bool> submitAnswer(List<AnswerFormat> answers, String taskId, double taskBudget) async {
    try {

      SharedPreferences _pref = await SharedPreferences.getInstance();
      String userId = _pref.getString("profile_id") ?? '';

      dio.options.headers['Content-Type'] = 'multipart/form-data';
      List<Map<String, dynamic>> finalAnswers = [];

      answers.forEach(
        (ans) async {
          finalAnswers.add(ans.toJson(taskId));
        }
      );

      // FormData formData = FormData.fromMap({
      //   'data': finalAnswers,
      // });;

      FormData formData = FormData();


      print("*************************************************");

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
                files.map((file) => MapEntry("files", file))); 
          };
        }
      );

      print("*************************************************");

      finalAnswers.forEach(
        (element) {
          print(element);
        }
      );





      print("-----------------------------------");
      print(finalAnswers);
      print("-----------------------------------");




      String formAns = jsonEncode(finalAnswers);

      print("----------------final ans-------------------");
      print(formAns);
      print("-----------------------------------");

      formData.fields.add(MapEntry("questionData", formAns));

      Response response = await dio.post(
        "/v1/response/responses/bulk",
        data: formData,
      );

      print("************************ done 1 *************************");

      if (response.statusCode != 201) {
        throw Exception("Error while submitting answers.");
      }

      print(taskId);
      print(userId);

      Response userTaskResp = await dio.post("/v1/task/users", 
      data: {
        "taskId": taskId,  "userId": userId 
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      );

      print(userTaskResp);


      print("************************ done  2 *************************");

      if (userTaskResp.statusCode != 201) {
        throw Exception("Error while creating userTask...");
      }




      Dio newDio = Dio();
      
      Response budgetResp = await newDio.get("http://54.162.136.11/api/v1/user/data-collector-profiles/$userId/", );

      double updateBudget = double.parse(budgetResp.data['current_balance']) + taskBudget;

      print(updateBudget);
      print("((((((((((((((((((((((((((((((((((((((${updateBudget}))))))))))))))))))))))))))))))))))))))");
      print(userId);


      await newDio.put("http://54.162.136.11/api/v1/user/data-collector-profiles/$userId/", 
        data: {
          "current_balance": updateBudget.toString(),
        },
      
      );


      // print("************************ Final *************************");

      return true;
    } catch (e) {
      print("@Error: $e");
      if (e  is DioException) {
        print("@Error: ${e.response}");
      }
      rethrow;
    }
  }

}

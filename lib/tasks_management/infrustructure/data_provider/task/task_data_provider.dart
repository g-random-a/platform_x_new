import 'dart:convert';
import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/services/hive/taskmanagment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/task/task.dart';
import '../../core/data_provider.dart';

class TasksDataProvider extends DataProvider {
  final Dio dio;
  final TaskManagerService taskManagerService;

  TasksDataProvider({required this.dio, required this.taskManagerService});

  Future<bool> submitTask(Task feedback) async {
    try {
      FormData formData = FormData.fromMap(feedback.toJson());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception("notLogged In");
      }
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['cookie'] = 'session=$token';

      Response response = await dio.post("/submit_task/", data: formData);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Error while sending feedback.");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> loadTasks() async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? token = prefs.getString('token');
      // if (token == null) {
      //   throw Exception("notLogged In");
      // }

      dio.options.headers['content-Type'] = 'application/json';
      // dio.options.headers['cookie'] = 'session=$token';
      // dio.options.headers['Authorization'] = 'Bearer $token';
      
      SharedPreferences _pref = await SharedPreferences.getInstance();

      String? profileId = _pref.getString("profile_id");

      Response response = await dio.get("/v1/task/user/$profileId");

      if (response.statusCode != 200) {
        throw Exception("Error while loading tasks.");
      }

      List<Task> tasks = [];

      List forms = response.data['tasks'];

      for (var form in forms) {

        Task task = Task.fromJson(form);

        if (taskManagerService.isTaksSaved(task.id)) {
          task.isFavorite = true;
          continue;
        }

        if (taskManagerService.isTaskOnProgress(task.id)) {
          continue;
        }

        tasks.add(task);
      }

      return tasks;

    } catch (e) {
      print("@Error: ${e}",);
      rethrow;
    }

  }


  Future<List<Task>> loadLocalTasks() async {
    try {

      List<Task> tasks = taskManagerService.getOnProgressTasks();
      
      return tasks;

    } catch (e) {
      print("@Error: ${e}",);
      rethrow;
    }

  }


  // Future<void> saveTask(Task task, {bool isOnProgress = true}) async {
  //   if (isOnProgress) {
  //     await onprogressBox.put(task.id, task);
  //   } else {
  //     await savedBox.put(task.id, task);
  //   }
  // }


  Future<bool> addLocalOnprogressTask (Task task) async {
    try {
      await taskManagerService.saveTask(task, isOnProgress: true);
      return true;
    } catch (e) {
      rethrow;
    }
  }

}
import 'package:platform_x/tasks_management/infrustructure/data_provider/task/task_data_provider.dart';

import '../../../domain/task/task.dart';

class TasksRepository {
  final TasksDataProvider tasksDataProvider;

  TasksRepository({required this.tasksDataProvider});

  Future<bool> submitTask(Task task) async {
    try {
      bool isTasksSent = await tasksDataProvider.submitTask(task);
      return isTasksSent;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> loadTasks() async {
    try {
      List<Task> tasks = await tasksDataProvider.loadTasks();
      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> loadMoreTasks(int nextPage) async{
    try {
      List<Task> tasks = await tasksDataProvider.loadMoreTasks(nextPage);
      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<List<Task>>> loadTasksHistory() async {
    try {
      List<List<Task>> tasks = await tasksDataProvider.loadTasksHistory();
      return tasks;
    } catch (e) {
      rethrow;
    }
  }
}
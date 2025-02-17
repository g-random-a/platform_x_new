import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platform_x/tasks_management/domain/task/task.dart';
import 'package:platform_x/tasks_management/domain/task/task_question_map.dart';

class TaskManagerService {
  late Box<Task> onprogressBox;
  late Box<Task> savedBox;
  late Box<TaskQuestionMap> taskQuestionMap;

  Future<void> initHive() async {
    await Hive.initFlutter(); 
    Hive.registerAdapter(TaskAdapter()); 
    Hive.registerAdapter(TaskQuestionMapAdapter());
    onprogressBox = await Hive.openBox<Task>('onprogressTasks');
    savedBox = await Hive.openBox<Task>('savedTasks');
    taskQuestionMap = await Hive.openBox<TaskQuestionMap>('taskQuestionMap');
  }

  Future<void> closeBoxes() async {
    await onprogressBox.close();
    await savedBox.close();
  }

  Future<void> saveTask(Task task, {bool isOnProgress = true}) async {
    if (isOnProgress) {
      await onprogressBox.put(task.id, task);
    } else {
      await savedBox.put(task.id, task);
    }
  }

  Future<void> deleteTask(String taskId, {bool isOnProgress = true, bool both = false}) async {
    if (isOnProgress || both) {
      await onprogressBox.delete(taskId);
    }  
    if (!isOnProgress || both) {
      await savedBox.delete(taskId);
    }
  }

  Task? getOnProgressTaskById(String id) {
    Task? task =  onprogressBox.get(id);
    if(task != null){
      return task;
    }
  }

  Task? getSavedTaskById(String id) {
    Task? task = savedBox.get(id);
    if(task != null){
      return task;
    }
  }

  bool isTaskOnProgress(String id) {
    return onprogressBox.containsKey(id);
  }

  bool isTaksSaved(String id) {
    return savedBox.containsKey(id);
  }

  bool isTaskOnProgressOrSaved(String id) {
    return isTaskOnProgress(id) || isTaksSaved(id);
  }

  List<Task> getOnProgressTasks() {
    return onprogressBox.values.toList();
  }

  List<Task> getSavedTasks() {
    return savedBox.values.toList();
  }

  Future<void> saveTaskQuestionMap(TaskQuestionMap taskQuestionMap) async {
    await this.taskQuestionMap.put(taskQuestionMap.taskId, taskQuestionMap);
  }

  TaskQuestionMap? getTaskQuestionMap(String taskId) {
    TaskQuestionMap? taskQuestionMap = this.taskQuestionMap.get(taskId);
    if(taskQuestionMap != null){
      return taskQuestionMap;
    }
  }
  

}

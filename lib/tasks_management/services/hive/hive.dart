import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:platform_x/tasks_management/domain/task/task.dart';

class TaskManagerService {
  late Box<Task> onprogressBox;
  late Box<Task> savedBox;

  Future<void> initHive() async {
    await Hive.initFlutter(); 
    Hive.registerAdapter(TaskAdapter()); 
    onprogressBox = await Hive.openBox<Task>('onprogressTasks');
    savedBox = await Hive.openBox<Task>('savedTasks');
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

  Task getOnProgressTaskById(String id) {
    Task? task =  onprogressBox.get(id);
    if(task != null){
      return task;
    }

    throw Exception('Task not found');
  }

  Task getSavedTaskById(String id) {
    Task? task = savedBox.get(id);
    if(task != null){
      return task;
    }

    throw Exception('Task not found');
  }

  bool isTaskOnProgress(String id) {
    return onprogressBox.containsKey(id);
  }

  bool isTaksSaved(String id) {
    return savedBox.containsKey(id);
  }

  List<Task> getOnProgressTasks() {
    return onprogressBox.values.toList();
  }

  List<Task> getSavedTasks() {
    return savedBox.values.toList();
  }
}

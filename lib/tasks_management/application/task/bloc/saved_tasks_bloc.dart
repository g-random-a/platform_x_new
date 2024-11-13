
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/tasks_management/application/task/event/saved_tasks_event.dart';
import 'package:platform_x/tasks_management/application/task/state/saved_task_state.dart';
import 'package:platform_x/tasks_management/services/hive/taskmanagment.dart';

import '../../../domain/task/task.dart';
import '../../../infrustructure/repository/task/task_repo.dart';
import '../event/task_event.dart';
import '../state/task_state.dart';

class SavedTasksBloc extends Bloc<SavedTasksEvent, SavedTasksState> {

  TaskManagerService taskManagerService;

  SavedTasksBloc({required this.taskManagerService})
      : super(SavedTasksInitialState()) {

    on<LoadSavedTasksEvent>(_loadSavedTasks);

    on<SaveToFavoriteEvent>(_saveToFavoriteEvent);
    on<RemoveFromFavoriteEvent>(_removeFromFavoriteEvent);
  }

  _loadSavedTasks(LoadSavedTasksEvent event, Emitter emit){
    emit(SavedTasksLoadingState());
    try {
      List<Task> tasks = taskManagerService.getSavedTasks();
      emit(SavedTasksLoadingSuccessState(tasks: tasks));
    } catch (e) {
      emit(SavedTasksLoadingFailedState());
    }
  }

  _saveToFavoriteEvent(SaveToFavoriteEvent event, Emitter emit) async {
    print("------------saving");
    try{
      await taskManagerService.saveTask(event.task, isOnProgress: false);
      List<Task> tasks = taskManagerService.getSavedTasks();
      emit(SavedTasksLoadingSuccessState(tasks: tasks));
    } catch (e) {
      emit(SavedTasksLoadingFailedState());
    }
  }
  
  _removeFromFavoriteEvent(RemoveFromFavoriteEvent event, Emitter emit) async {
    print("-------------------removing");
    try{
      await taskManagerService.deleteTask(event.task.id, isOnProgress: false);
      List<Task> tasks = taskManagerService.getSavedTasks();
      emit(SavedTasksLoadingSuccessState(tasks: tasks));
    } catch (e) {
      emit(SavedTasksLoadingFailedState());
    }
  }
  


  
}
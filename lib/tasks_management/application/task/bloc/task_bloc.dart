
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/task/task.dart';
import '../../../infrustructure/repository/task/task_repo.dart';
import '../event/task_event.dart';
import '../state/task_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksRepository tasksRepository;
  TasksBloc({required this.tasksRepository})
      : super(TasksInitialState()) {

    on<LoadTasksEvent>(LoadTasks);
    // on<LoadMoreTasksEvent>(loadMoreTasks);
    on<DisposeTasksEvent>((DisposeTasksEvent event, Emitter emit) {
      emit(TasksInitialState());
    });
  }

  LoadTasks(LoadTasksEvent event, Emitter emit) async {
    // if (state is  !TasksLoadingSuccessState){
      emit(TasksLoadingState());
    // }
    // else{
    //   emit(TasksLoadingSuccessState(tasks: (state as TasksLoadingSuccessState).tasks, isLoadingMore: true));
    // }
    try {
      List<Task> tasks = await tasksRepository.loadTasks();
      emit(TasksLoadingSuccessState(tasks: tasks));
    } catch (e) {
      emit(TasksLoadingFailedState());
    }
  }

  
}
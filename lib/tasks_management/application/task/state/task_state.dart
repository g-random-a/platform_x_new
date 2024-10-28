import 'package:equatable/equatable.dart';
import '../../../domain/task/task.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

class TasksInitialState extends TasksState {}

class TasksLoadingState extends TasksState {}

class TasksLoadingSuccessState extends TasksState {
  final List<Task> tasks;

  final bool isLoadingMore;
  final int nextPage;
  final int limit;
  final String error;

  const TasksLoadingSuccessState({required this.tasks, this.isLoadingMore = false, this.nextPage = 1, this.limit = 10, this.error = ''});

  @override
  List<Object?> get props => [tasks, isLoadingMore, error, nextPage, limit];
}

class TasksLoadingFailedState extends TasksState {}
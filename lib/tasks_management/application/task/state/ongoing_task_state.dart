import 'package:equatable/equatable.dart';
import '../../../domain/task/task.dart';

abstract class OngoingTasksState extends Equatable {
  const OngoingTasksState();

  @override
  List<Object?> get props => [];
}

class OngoingTasksInitialState extends OngoingTasksState {}

class OngoingTasksLoadingState extends OngoingTasksState {}

class OngoingTasksLoadingSuccessState extends OngoingTasksState {
  final List<Task> ongoingTasks;
  
  final bool isLoadingMore;
  final int nextPage;
  final int limit;
  final String error;

  const OngoingTasksLoadingSuccessState({required this.ongoingTasks, this.isLoadingMore = false, this.nextPage = 1, this.limit = 10, this.error = ''});

  @override
  List<Object?> get props => [ongoingTasks, isLoadingMore, error, nextPage, limit];
}

class OngoingTasksLoadingFailedState extends OngoingTasksState {}
import 'package:equatable/equatable.dart';
import '../../../domain/task/task.dart';

abstract class SavedTasksState extends Equatable {
  const SavedTasksState();

  @override
  List<Object?> get props => [];
}

class SavedTasksInitialState extends SavedTasksState {}

class SavedTasksLoadingState extends SavedTasksState {}

class SavedTasksLoadingSuccessState extends SavedTasksState {
  final List<Task> SavedTasks;
  
  final bool isLoadingMore;
  final int nextPage;
  final int limit;
  final String error;

  SavedTasksLoadingSuccessState({required this.SavedTasks, this.isLoadingMore = false, this.nextPage = 1, this.limit = 10, this.error = ''});

  @override
  List<Object?> get props => [SavedTasks, isLoadingMore, error, nextPage, limit];
}

class SavedTasksLoadingFailedState extends SavedTasksState {}
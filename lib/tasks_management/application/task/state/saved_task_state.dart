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
  final List<Task> tasks;

  const SavedTasksLoadingSuccessState({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class SavedTasksLoadingFailedState extends SavedTasksState {}
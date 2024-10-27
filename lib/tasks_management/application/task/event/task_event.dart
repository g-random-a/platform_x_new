import 'package:equatable/equatable.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TasksEvent {
}

class LoadMoreTasksEvent extends TasksEvent {
}

class LoadOngoingTasksEvent extends TasksEvent {
}

class DisposeTasksEvent extends TasksEvent {
  const DisposeTasksEvent();

  @override
  List<Object?> get props => [];
}
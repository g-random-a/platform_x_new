import 'package:equatable/equatable.dart';
import 'package:platform_x/tasks_management/domain/task/task.dart';

abstract class SavedTasksEvent extends Equatable {
  const SavedTasksEvent();

  @override
  List<Object?> get props => [];
}

class LoadSavedTasksEvent extends SavedTasksEvent {
}

class SaveToFavoriteEvent extends SavedTasksEvent{
  final Task task;

  const SaveToFavoriteEvent({required this.task});

  @override
  List<Object?> get props => [task];
}

class RemoveFromFavoriteEvent extends SavedTasksEvent{
  final Task task;

  const RemoveFromFavoriteEvent({required this.task});

  @override
  List<Object?> get props => [task];
}


class DisposeSavedTasksEvent extends SavedTasksEvent {
  const DisposeSavedTasksEvent();

  @override
  List<Object?> get props => [];
}
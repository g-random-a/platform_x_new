import 'package:equatable/equatable.dart';

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuestionsEvent extends QuestionsEvent {
  final String taskId;

  const LoadQuestionsEvent({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}

class DisposeQuestionsEvent extends QuestionsEvent {
  const DisposeQuestionsEvent();

  @override
  List<Object?> get props => [];
}
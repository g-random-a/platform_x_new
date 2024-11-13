import 'package:equatable/equatable.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';

abstract class AnswerEvent extends Equatable {
  const AnswerEvent();

  @override
  List<Object?> get props => [];
}

class SubmitAnswerEvent extends AnswerEvent {
  String taskId;

  SubmitAnswerEvent({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}

class UpdateAnswerEvent extends AnswerEvent {
  final IAnswer answer;
  final String questionId;

  const UpdateAnswerEvent({required this.answer, required this.questionId});

  @override
  List<Object?> get props => [answer];
}

class DisposeAnswerEvent extends AnswerEvent {
  const DisposeAnswerEvent();

  @override
  List<Object?> get props => [];
}
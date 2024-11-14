import 'package:equatable/equatable.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';

abstract class CurrentAnswerEvent extends Equatable {
  const CurrentAnswerEvent();

  @override
  List<Object?> get props => [];
}

class InitCurrentAnswerEvent extends CurrentAnswerEvent {
  const InitCurrentAnswerEvent();

  @override
  List<Object?> get props => [];
}

class LoadLocalAnswerEvent extends CurrentAnswerEvent {
  final String taskId;

  const LoadLocalAnswerEvent({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}

class SubmitCurrentAnswerEvent extends CurrentAnswerEvent {
  final dynamic questionId;
  final String taskId;
  
  const SubmitCurrentAnswerEvent({required this.questionId, required this.taskId});

  @override
  List<Object?> get props => [questionId, taskId];
}

class UpdateCurrentAnswerEvent extends CurrentAnswerEvent {
  final IAnswer answer;
  final String questionId;

  const UpdateCurrentAnswerEvent({required this.answer, required this.questionId});

  @override
  List<Object?> get props => [answer];
}

class DisposeCurrentAnswerEvent extends CurrentAnswerEvent {
  const DisposeCurrentAnswerEvent();

  @override
  List<Object?> get props => [];
}
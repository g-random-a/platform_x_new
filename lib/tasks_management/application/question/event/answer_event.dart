import 'package:equatable/equatable.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';

abstract class AnswerEvent extends Equatable {
  const AnswerEvent();

  @override
  List<Object?> get props => [];
}

class SubmitAnswerEvent extends AnswerEvent {

  const SubmitAnswerEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAnswerEvent extends AnswerEvent {
  final IAnswer answer;
  const UpdateAnswerEvent({required this.answer});

  @override
  List<Object?> get props => [answer];
}

class DisposeAnswerEvent extends AnswerEvent {
  const DisposeAnswerEvent();

  @override
  List<Object?> get props => [];
}
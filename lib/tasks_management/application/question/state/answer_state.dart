import 'package:equatable/equatable.dart';

import '../../../domain/answerType.dart';

abstract class AnswerState extends Equatable {
  const AnswerState({required this.answers});

  final Map<String, IAnswer> answers;

  @override
  List<Object?> get props => [];
}

class AnswerInitialState extends AnswerState {
  const AnswerInitialState({required super.answers});
}

class AnswerLoadingState extends AnswerState {
  const AnswerLoadingState({required super.answers});
}

class AnswerSubmittedState extends AnswerState {
  const AnswerSubmittedState({required super.answers});
}

class AnswerSubmitionFailedState extends AnswerState {
  final String? error;

  const AnswerSubmitionFailedState({this.error, required super.answers});
  
}
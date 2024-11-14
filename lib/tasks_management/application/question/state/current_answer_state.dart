import 'package:equatable/equatable.dart';

import '../../../domain/answerType.dart';

abstract class CurrentAnswerState extends Equatable {
  const CurrentAnswerState({required this.answers, this.currentAnswer});

  final Map<String, IAnswer> answers;
  final IAnswer? currentAnswer;

  @override
  List<Object?> get props => [answers];
}

class CurrentAnswerInitialState extends CurrentAnswerState {
  const CurrentAnswerInitialState({required super.answers, super.currentAnswer});

  @override
  List<Object?> get props => [answers];
}

class CurrentAnswerLoadingState extends CurrentAnswerState {
  const CurrentAnswerLoadingState({required super.answers, super.currentAnswer});

  @override
  List<Object?> get props => [answers];
}

class CurrentAnswerSubmittedState extends CurrentAnswerState {
  const CurrentAnswerSubmittedState({required super.answers, super.currentAnswer});

  @override
  List<Object?> get props => [answers];
}

class CurrentAnswerSubmitionFailedState extends CurrentAnswerState {
  final String? error;

  const CurrentAnswerSubmitionFailedState({this.error, required super.answers, super.currentAnswer});

  @override
  List<Object?> get props => [answers, error];
  
}

class CurrentAnswerUpdatedState extends CurrentAnswerState {
  const CurrentAnswerUpdatedState({required super.answers, super.currentAnswer});

  @override
  List<Object?> get props => [answers];
}

class CurrentAnswerUpdateFailedState extends CurrentAnswerState {
  final String? error;

  const CurrentAnswerUpdateFailedState({this.error, required super.answers, super.currentAnswer});

  @override
  List<Object?> get props => [answers, error];
}

class CurrentAnswerLoadingSuccessState extends CurrentAnswerState {
  const CurrentAnswerLoadingSuccessState({required super.answers, super.currentAnswer});

  @override
  List<Object?> get props => [answers];
}

class CurrentAnswerLoadingFailedState extends CurrentAnswerState {
  final String? error;

  const CurrentAnswerLoadingFailedState({this.error, required super.answers, super.currentAnswer});

  @override
  List<Object?> get props => [answers, error];
}
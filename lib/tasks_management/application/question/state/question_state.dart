import 'package:equatable/equatable.dart';
import 'package:platform_x/tasks_management/domain/questionTypes.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object?> get props => [];
}

class QuestionsInitialState extends QuestionsState {}

class QuestionsLoadingState extends QuestionsState {}

class QuestionsLoadingSuccessState extends QuestionsState {
  final List<IQuestion> questions;

  const QuestionsLoadingSuccessState({required this.questions});

  @override
  List<Object?> get props => [questions]; 
}

class QuestionsLoadingFailedState extends QuestionsState {
  final String? error;

  const QuestionsLoadingFailedState({this.error});
  
}
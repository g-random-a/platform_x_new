import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/tasks_management/infrustructure/repository/answer/answer_repository.dart';

import '../event/answer_event.dart';
import '../state/answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  AnswerRepository answerRepository;

  AnswerBloc({required this.answerRepository})
      : super(const AnswerInitialState(answers: {})) {

    on<SubmitAnswerEvent>(submitAnswer);
    on<DisposeAnswerEvent>((DisposeAnswerEvent event, Emitter emit) {
      emit(const AnswerInitialState(answers: {}));
    });

  }

  submitAnswer(SubmitAnswerEvent event, Emitter emit) async {
      emit(AnswerLoadingState(answers: state.answers));
    try {
      await answerRepository.submitAnswer(state.answers);
      emit(AnswerSubmittedState(answers: state.answers));
    } catch (e) {
      emit(AnswerSubmitionFailedState(answers: state.answers));
    }
  }

  

}
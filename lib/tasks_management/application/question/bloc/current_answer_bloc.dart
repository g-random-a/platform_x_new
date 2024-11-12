import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/tasks_management/infrustructure/repository/answer/answer_repository.dart';
import 'package:platform_x/tasks_management/services/hive/answermanagment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/answerType.dart';
import '../event/current_answer_event.dart';
import '../state/current_answer_state.dart';


class CurrentAnswerBloc extends Bloc<CurrentAnswerEvent, CurrentAnswerState> {
  AnswerRepository answerRepository;
  AnswerManagement answerManagerService;

  CurrentAnswerBloc({required this.answerRepository, required this.answerManagerService})
      : super(const CurrentAnswerInitialState(answers: {})) {

    on<UpdateCurrentAnswerEvent>(updateCurrentAnswer);
    on<SubmitCurrentAnswerEvent>(submitCurrentAnswer);
    on<DisposeCurrentAnswerEvent>((DisposeCurrentAnswerEvent event, Emitter emit) {
      emit(const CurrentAnswerInitialState(answers: {}));
    });
  }

  submitCurrentAnswer(SubmitCurrentAnswerEvent event, Emitter emit) async {
      emit(CurrentAnswerLoadingState(answers: state.answers));
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final userId = _pref.getString("user_id");
      if (!userId!.isNotEmpty) {
        emit(CurrentAnswerSubmitionFailedState(answers: state.answers));
        return;
      }
      AnswerFormat myAnswer = AnswerFormat(userId: userId, questionId: event.questionId, answers: state.answers.values.toList());
      await answerManagerService.addOrUpdateAnswer(myAnswer);
      emit(CurrentAnswerSubmittedState(answers: state.answers));
    } catch (e) {
      emit(CurrentAnswerSubmitionFailedState(answers: state.answers));
    }
  }

  updateCurrentAnswer(UpdateCurrentAnswerEvent event, Emitter emit) async {
    try { 
      Map<String, IAnswer> answers = Map.from(state.answers);
      print(answers["${event.questionId}_${event.answer.id}" ]);
      answers["${event.questionId}_${event.answer.id}" ] = event.answer;
      emit(CurrentAnswerUpdatedState(answers: answers));
    } catch (e) {
      print(e);
      emit(CurrentAnswerUpdateFailedState(answers: state.answers));
    }
  }


}
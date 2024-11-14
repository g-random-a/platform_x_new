import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/tasks_management/domain/task/task_question_map.dart';
import 'package:platform_x/tasks_management/infrustructure/repository/answer/answer_repository.dart';
import 'package:platform_x/tasks_management/services/hive/answermanagment.dart';
import 'package:platform_x/tasks_management/services/hive/taskmanagment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/answerType.dart';
import '../event/current_answer_event.dart';
import '../state/current_answer_state.dart';


class CurrentAnswerBloc extends Bloc<CurrentAnswerEvent, CurrentAnswerState> {
  AnswerRepository answerRepository;
  AnswerManagement answerManagerService;
  TaskManagerService taskManagerService;

  CurrentAnswerBloc({required this.answerRepository, required this.answerManagerService, required this.taskManagerService})
      : super(const CurrentAnswerInitialState(answers: {} )) {

    on<LoadLocalAnswerEvent>(loadLocalAnswersEvent);
    on<UpdateCurrentAnswerEvent>(updateCurrentAnswer);
    on<SubmitCurrentAnswerEvent>(submitCurrentAnswer);
    on<DisposeCurrentAnswerEvent>((DisposeCurrentAnswerEvent event, Emitter emit) {
      emit(const CurrentAnswerInitialState(answers: {}));
    });
  }

  loadLocalAnswersEvent(LoadLocalAnswerEvent event, Emitter emit) async {
    emit(CurrentAnswerLoadingState(answers: state.answers));
    try {

      TaskQuestionMap? taskIdMapper = taskManagerService.getTaskQuestionMap(event.taskId);
      if (taskIdMapper == null) {
        emit(CurrentAnswerLoadingFailedState(answers: state.answers));
        return;
      }

      Map<String, IAnswer> answersMap = {};
      taskIdMapper.questionId.forEach((id) {
        print("iiiiiddddddddddddddddd: ${id}");
        AnswerFormat? currentAnswer = answerManagerService.getAnswerByQuestionId(id);
        if (currentAnswer != null){
          currentAnswer.answers.forEach(
            (element) {
            print("ele id: ${element.id}");

              answersMap["${id}_${element.id}"] = element;
            }
          );
        }
      });

      emit(CurrentAnswerLoadingSuccessState(answers: answersMap));
    } catch (e) {
      emit(CurrentAnswerLoadingFailedState(answers: state.answers));
    }
  }

  submitCurrentAnswer(SubmitCurrentAnswerEvent event, Emitter emit) async {
      emit(CurrentAnswerLoadingState(answers: state.answers));
    try {
      if(state.answers.isNotEmpty){
           SharedPreferences _pref = await SharedPreferences.getInstance();
          final userId = _pref.getString("profile_id");
          if (!userId!.isNotEmpty) {
            emit(CurrentAnswerSubmitionFailedState(answers: state.answers));
            return;
          }

          IAnswer curr_answers = state.answers.values.last;
          
          AnswerFormat myAnswer = AnswerFormat(userId: userId, questionId: event.questionId, answers: [curr_answers]);
          await answerManagerService.addOrUpdateAnswer(myAnswer);
      }
      emit(const CurrentAnswerSubmittedState(answers: {}));
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
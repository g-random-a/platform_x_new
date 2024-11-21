import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:platform_x/tasks_management/domain/task/task_question_map.dart';
import 'package:platform_x/tasks_management/infrustructure/repository/answer/answer_repository.dart';
import 'package:platform_x/tasks_management/services/hive/answermanagment.dart';
import 'package:platform_x/tasks_management/services/hive/taskmanagment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../event/answer_event.dart';
import '../state/answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  AnswerRepository answerRepository;
  TaskManagerService taskManagerService;
  AnswerManagement answerManagement;

  AnswerBloc({required this.answerRepository, required this.taskManagerService, required this.answerManagement})
      : super(const AnswerInitialState(answers: {})) {

    on<SubmitAnswerEvent>(submitAnswer);
    on<DisposeAnswerEvent>((DisposeAnswerEvent event, Emitter emit) {
      emit(const AnswerInitialState(answers: {}));
    });

  }

  submitAnswer(SubmitAnswerEvent event, Emitter emit) async {
      emit(const AnswerLoadingState(answers: {}));
    try {

      TaskQuestionMap? taskQuestions = taskManagerService.getTaskQuestionMap(event.taskId);

      List<AnswerFormat> finalAnswers = [];

      if (taskQuestions != null) {
        taskQuestions.questionId.forEach((id) {
        AnswerFormat? currentAnswer = answerManagement.getAnswerByQuestionId(id);
        if(currentAnswer != null) {
          finalAnswers.add(currentAnswer);
        }
      });
      }
      
      await answerRepository.submitAnswer(finalAnswers, event.taskId, event.taskBudget);

      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setDouble("current_balance", _pref.getDouble("current_balance")??0 + event.taskBudget);

      emit(AnswerSubmittedState(answers: state.answers));
    } catch (e) {
      emit(AnswerSubmitionFailedState(answers: state.answers));
    }
  }

  

}
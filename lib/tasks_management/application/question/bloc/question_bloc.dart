import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/tasks_management/domain/task/task_question_map.dart';
import 'package:platform_x/tasks_management/services/hive/taskmanagment.dart';

import '../../../domain/questionTypes.dart';
import '../../../infrustructure/repository/question/question_repo.dart';
import '../event/question_event.dart';
import '../state/question_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsRepository questionsRepository;
  TaskManagerService taskManagerService;

  QuestionsBloc({required this.questionsRepository, required this.taskManagerService})
      : super(QuestionsInitialState()) {

    on<LoadQuestionsEvent>(loadQuestions);
    on<DisposeQuestionsEvent>((DisposeQuestionsEvent event, Emitter emit) {
      emit(QuestionsInitialState());
    });
  }

  loadQuestions(LoadQuestionsEvent event, Emitter emit) async {
      emit(QuestionsLoadingState());
    try {
      List<IQuestion> questions = await questionsRepository.loadQuestions(event.taskId);
      TaskQuestionMap taskQuestionMap = TaskQuestionMap(taskId: event.taskId, questionId: questions.map((ele) => ele.id ?? "").toList() );
      await taskManagerService.saveTaskQuestionMap(taskQuestionMap);
      emit(QuestionsLoadingSuccessState(questions: questions));
    } catch (e) {
      emit(QuestionsLoadingFailedState());
    }
  }

}
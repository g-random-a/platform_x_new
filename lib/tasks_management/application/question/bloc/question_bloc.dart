import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/questionTypes.dart';
import '../../../infrustructure/repository/question/question_repo.dart';
import '../event/question_event.dart';
import '../state/question_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsRepository questionsRepository;

  QuestionsBloc({required this.questionsRepository})
      : super(QuestionsInitialState()) {

    on<LoadQuestionsEvent>(LoadQuestions);
    on<DisposeQuestionsEvent>((DisposeQuestionsEvent event, Emitter emit) {
      emit(QuestionsInitialState());
    });
  }

  LoadQuestions(LoadQuestionsEvent event, Emitter emit) async {
      emit(QuestionsLoadingState());
    try {
      List<IQuestion> questions = await questionsRepository.loadQuestions(event.taskId);
      emit(QuestionsLoadingSuccessState(questions: questions));
    } catch (e) {
      emit(QuestionsLoadingFailedState());
    }
  }

}
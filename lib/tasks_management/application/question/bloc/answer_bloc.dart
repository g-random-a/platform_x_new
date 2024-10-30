// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../domain/answerType.dart';
// import '../event/answer_event.dart';
// import '../state/answer_state.dart';

// class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
//   AnswerRepository answerRepository;

//   AnswerBloc({required this.AnswerRepository})
//       : super(const AnswerInitialState(answers: {})) {

//     on<SubmitAnswerEvent>(submitAnswer);
//     on<UpdateAnswerEvent>(updateAnswer);
//     on<DisposeAnswerEvent>((DisposeAnswerEvent event, Emitter emit) {
//       emit(const AnswerInitialState(answers: {}));
//     });

//   }

//   submitAnswer(SubmitAnswerEvent event, Emitter emit) async {
//       emit(AnswerLoadingState(answers: state.answers));
//     try {
//       await AnswerRepository.submitAnswer();
//       emit(AnswerSubmittedState(answers: state.answers));
//     } catch (e) {
//       emit(AnswerSubmitionFailedState(answers: state.answers));
//     }
//   }


//   updateAnswer(UpdateAnswerEvent event, Emitter emit) async {
//     Map<String, IAnswer> answers = state.answers;
//     answers[event.answer.id.toString()] = event.answer;
//     // emit(AnswerInitialState(answers: answers));
//     emit(AnswerInitialState(answers: answers));
//   }

// }
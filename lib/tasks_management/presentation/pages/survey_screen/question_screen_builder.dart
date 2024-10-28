import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/application/question/bloc/question_bloc.dart';
import 'package:platform_x/tasks_management/application/question/event/question_event.dart';
import 'package:platform_x/tasks_management/application/question/state/question_state.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/surver_screen.dart';

class QuestionScreeenBuilder extends StatefulWidget {
  const QuestionScreeenBuilder({super.key});

  @override
  State<QuestionScreeenBuilder> createState() => _QuestionScreeenBuilderState();
}

class _QuestionScreeenBuilderState extends State<QuestionScreeenBuilder> {

  PageController _pageController = PageController();

  void nextPage () {
    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<QuestionsBloc, QuestionsState>(
          builder: (context, state) {
          if (state is QuestionsLoadingSuccessState) {
            int totalQuestions = state.questions.length;
            if(totalQuestions == 0){
              return Column(
                children: [
                  const Text('No questions found'),
                  CustomElevatedButton(
                    onclick: (){
                      context.pop();
                    },
                    text: "Back",
                    backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.whiteA700,
                    )
                ],
              );
            }
            return PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: totalQuestions,
              itemBuilder: (context, index) {
                  return SurveyScreen(question: state.questions[index], currentIndex: index + 1, totalQuestions: totalQuestions, nextPage: nextPage);
              },
              
              );
          }
          return const Center(child: CircularProgressIndicator());
          }
        )
      ),
    );
  }
}
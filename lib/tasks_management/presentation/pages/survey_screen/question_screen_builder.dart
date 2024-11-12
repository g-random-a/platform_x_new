import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/application/question/bloc/current_answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/bloc/question_bloc.dart';
import 'package:platform_x/tasks_management/application/question/event/current_answer_event.dart';
import 'package:platform_x/tasks_management/application/question/state/question_state.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/surver_screen.dart';
import 'package:platform_x/tasks_management/services/hive/taskmanagment.dart';

class QuestionScreeenBuilder extends StatefulWidget {
  const QuestionScreeenBuilder({super.key});

  @override
  State<QuestionScreeenBuilder> createState() => _QuestionScreeenBuilderState();
}

class _QuestionScreeenBuilderState extends State<QuestionScreeenBuilder> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setStatusBarColor();
    });
  }

  void _setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.watch<ThemeBloc>().state.appColorTheme.whiteA700, // Use context to get color
        statusBarIconBrightness: context.watch<ThemeBloc>().isDarkMode ? Brightness.dark : Brightness.light, // Adjust brightness based on color
      ),
    );
  }


  PageController _pageController = PageController(keepPage: true, initialPage:3 );

  void nextPage () {
    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void prevPage(){
    _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<QuestionsBloc, QuestionsState>(
          builder: (context, state) {
          if (state is QuestionsLoadingSuccessState) {
            int totalQuestions = state.questions.length;
            if(totalQuestions == 0){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).t_no_questions_found),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: CustomElevatedButton(
                      onclick: (){
                        context.pop();
                      },
                      text: S.of(context).t_back,
                      textColor: context.watch<ThemeBloc>().state.appColorTheme.whiteA700,
                      backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.black90001,
                      ),
                  )
                ],
              );
            }
            return PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: totalQuestions,
              itemBuilder: (context, index) {
                  return SurveyScreen(question: state.questions[index], currentIndex: index + 1, totalQuestions: totalQuestions, nextPage: nextPage, prevPage: prevPage,);
              },
              
              );
          }
          return const Center(child: CircularProgressIndicator());
          }
        ),
      )
    );
  }
}
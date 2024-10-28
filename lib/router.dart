import 'package:go_router/go_router.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/question_screen_builder.dart';

import 'tasks_management/presentation/pages/home_page.dart';
import 'tasks_management/presentation/pages/not_found/not_found.dart';
import 'tasks_management/presentation/pages/survey_screen/surver_screen.dart';
import 'tasks_management/presentation/pages/task_instruction/task_instruction.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes:  [
        GoRoute(
          path: '/task_instruction',
          builder: (context, state) {
            final props = state.extra as Map<String, dynamic>?; 
            if (props != null) {
              return TaskInstructionScreen(task: props['task']);
            } 
            return const NotFound();
          },
        ),
        GoRoute(
          path: "/Survey",
          builder: (context, state) => const QuestionScreeenBuilder(),
          // builder: (context, state) {
          //   final props = state.extra as Map<String, dynamic>?; 
          //   if (props != null) {
          //     return SurveyScreen(currentIndex: props['currentIndex'], totalQuestions: props['totalQuestions'], question: props['question'],);
          //   } 

          //   return const NotFound();
          // },
          )
      ],
    ),

  ],
);
import 'package:go_router/go_router.dart';

import 'tasks_management/presentation/pages/home_page.dart';
import 'tasks_management/presentation/pages/survey_screen/surver_screen.dart';
import 'tasks_management/presentation/pages/task_instruction/task_instruction.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
      routes:  [
        GoRoute(
          path: '/task_instruction',
          builder: (context, state) {
            final props = state.extra as Map<String, dynamic>?; 
            return TaskInstructionScreen(task: props!['task']); 
          },
        ),
        GoRoute(
          path: "/Survey",
          builder: (context, state) => SurveyScreen(),
          )
      ],
    ),

  ],
);
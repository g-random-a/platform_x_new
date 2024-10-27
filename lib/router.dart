import 'package:go_router/go_router.dart';

import 'tasks_management/presentation/pages/home_page.dart';
import 'tasks_management/presentation/pages/survey_screen/components/map_viewer.dart';
import 'tasks_management/presentation/pages/survey_screen/components/photo_taker.dart';
import 'tasks_management/presentation/pages/survey_screen/surver_screen.dart';
import 'tasks_management/presentation/pages/task_instruction/task_instruction.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SurveyScreen(),
      routes:  [
        GoRoute(
          path: '/task_instruction',
          builder: (context, state) => TaskInstructionScreen(),
        ),
        GoRoute(
          path: "/Survey",
          builder: (context, state) => SurveyScreen(),
          )
      ],
    ),

  ],
);
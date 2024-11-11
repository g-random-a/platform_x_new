import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_x/tasks_management/presentation/pages/home_page.dart';
import 'package:platform_x/tasks_management/presentation/pages/not_found/not_found.dart';
import 'package:platform_x/tasks_management/presentation/pages/question_completion/completion_approval_screen.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/question_screen_builder.dart';
import 'package:platform_x/tasks_management/presentation/pages/task_instruction/task_instruction.dart';

import '../core/application/auth/bloc/check_auth_bloc.dart';

List<GoRoute> taskManagementRoutes = [
  GoRoute(
      redirect: (context, state) {
        final authState = context.read<AuthBloc>().state;
        final isLoggedIn = authState.isAuthenticated;

        if (!isLoggedIn) {
          return '/';
        }
        return null;
      },
      path: '/tasks',
      builder: (context, state) => const HomePage(),
      routes:  [
        GoRoute(
          path: '/task_instruction',
          builder: (context, state) {
            final props = state.extra as Map<String, dynamic>?; 
            if (props != null) {
              print(props);
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
          ),
        GoRoute(
          path: "/CompeletedSuccessfully",
          builder: (context, state) => CompletionApprovalScreen(),
          )
      ],
    ),

];
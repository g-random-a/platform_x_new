import 'package:go_router/go_router.dart';
import 'package:platform_x/tasks_management/router.dart';

import 'onboarding/App Start/screen/onboarding_screen.dart';
import 'onboarding/App Start/screen/welcome_screen.dart';
import 'onboarding/AuthModule/screen/File Upload/file upload.dart';
import 'onboarding/AuthModule/screen/Log In/sign in.dart';
import 'onboarding/AuthModule/screen/Profile Creation/stepper.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    ...taskManagementRoutes,
    GoRoute(
      path: '/',
      builder: (context, state) => WelcomeScreen(),
      routes: const [
      ],
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LogIn(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const NewProfilePageScreen(),
    ),
    GoRoute(
      path: '/document',
      builder: (context, state) => const UploadDocumentsScreen(),
    ),

  ],
);
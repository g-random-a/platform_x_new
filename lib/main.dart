import 'package:flutter/services.dart';
import 'package:platform_x/core/application/auth/bloc/check_auth_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/tasks_management/application/question/bloc/answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/bloc/current_answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/bloc/question_bloc.dart';
import 'package:platform_x/tasks_management/application/task/bloc/saved_tasks_bloc.dart';
import 'package:platform_x/tasks_management/application/task/event/saved_tasks_event.dart';
import 'package:platform_x/tasks_management/infrustructure/data_provider/answer/answer_data_provider.dart';
import 'package:platform_x/tasks_management/infrustructure/data_provider/profile/user_profile.dart';
import 'package:platform_x/tasks_management/infrustructure/data_provider/question/question_data_provider.dart';
import 'package:platform_x/tasks_management/infrustructure/repository/answer/answer_repository.dart';
import 'package:platform_x/tasks_management/infrustructure/repository/profile/user_profile.dart';
import 'package:platform_x/tasks_management/infrustructure/repository/question/question_repo.dart';
import 'package:platform_x/tasks_management/infrustructure/repository/task/task_repo.dart';
import 'package:platform_x/tasks_management/services/hive/answermanagment.dart';
import 'package:platform_x/tasks_management/services/hive/taskmanagment.dart';
import 'package:platform_x/tasks_management/services/sharedPref/sharedpref.dart';

import 'core/application/auth/event/check_auth_event.dart';
import 'lib.dart';
import 'tasks_management/application/task/bloc/task_bloc.dart';
import 'tasks_management/infrustructure/data_provider/task/task_data_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _requestPermissions() async {
  bool microphonePermission = await Permission.microphone.isGranted;
  if (!microphonePermission) await Permission.microphone.request();
  
  bool storagePermission = await Permission.storage.isGranted;
  if (!storagePermission) await Permission.storage.request();
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  await _requestPermissions();

  await dotenv.load();

  final taskManager = TaskManagerService();
  await taskManager.initHive();

  final answerManager = AnswerManagement();
  await answerManager.init();

  final DioService dioService = DioService();

  await SharedPrefService.init();

  final localBloc = LocaleBloc();
  localBloc.add(LoadLocaleEvent());

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TaskManagerService>(
          create: (context) => taskManager,
        ),
        RepositoryProvider<AnswerManagement>(
          create: (context) => answerManager,
        ),
        RepositoryProvider<TasksRepository>(
          create: (context) => TasksRepository(tasksDataProvider: TasksDataProvider(dio: dioService.dio, taskManagerService: taskManager)),
        ),
        RepositoryProvider<QuestionsRepository>(
          create: (context) => QuestionsRepository(tasksDataProvider: QuestionsDataProvider(dio: dioService.dio)),
          ),
        RepositoryProvider<UserProfileRepository>(
          create: (context) => UserProfileRepository(userDataProvider: UserProfileDataProvider(dio: dioService.dio))
          ),
        RepositoryProvider<AnswerRepository>(
          create: (context) => AnswerRepository(answerDataProvider: AnswerDataProvider(dio: dioService.dio)),
        )
            ], 
      child: MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(taskManagerService: taskManager)..add(LoadThemeEvent()),
        ),
        BlocProvider<LocaleBloc>(
          create: (context) => localBloc),
        BlocProvider(
          create: (context) => TasksBloc(tasksRepository: context.read<TasksRepository>()),
        ),
        BlocProvider(
          create: (context) => QuestionsBloc(questionsRepository: context.read<QuestionsRepository>(), taskManagerService: taskManager),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthLoadEvent()),
        ),
        BlocProvider(create: (context) => SavedTasksBloc(taskManagerService: taskManager)..add(LoadSavedTasksEvent())),
        BlocProvider(create: (context) => CurrentAnswerBloc(answerRepository: context.read<AnswerRepository>(), answerManagerService: answerManager, taskManagerService: taskManager)),
        BlocProvider(create: (context) => AnswerBloc(answerRepository: context.read<AnswerRepository>(), answerManagement: answerManager, taskManagerService: taskManager)),
      ],
     child: const MyApp(),
        )
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return BlocBuilder<LocaleBloc, LocaleState>(
              builder: (localeContext, localeState) {
                return MaterialApp.router(
                  title: 'Platform X',
                  locale: localeState.locale,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    OromoMaterialLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  localeResolutionCallback: (locale, supportedLocales) {
                      if (locale?.languageCode == 'oro') {
                      return const Locale('oro');
                    }
                    for (var supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode == locale?.languageCode &&
                          supportedLocale.countryCode == locale?.countryCode) {
                        return supportedLocale;
                      }
                    }
                    return supportedLocales.first;
                  },
                  theme: state.themeData,
                  routerConfig: appRouter,
                  debugShowCheckedModeBanner: false,
                );
              }
            );
          }
        );
      }
    );
  }
}

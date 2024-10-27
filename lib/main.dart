import 'package:flutter/services.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/tasks_management/infrustructure/repository/task/task_repo.dart';

import 'lib.dart';
import 'tasks_management/application/task/bloc/task_bloc.dart';
import 'tasks_management/infrustructure/data_provider/task/task_data_provider.dart';
import 'tasks_management/presentation/components/task_card.dart';
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
  final DioService dioService = DioService();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TasksRepository>(
          create: (context) => TasksRepository(tasksDataProvider: TasksDataProvider(dio: dioService.dio)),
        ),
            ], 
      child: MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(LoadThemeEvent()),
        ),
        BlocProvider<LocaleBloc>(
          create: (context) => LocaleBloc(),
        ),
        BlocProvider(
          create: (context) => TasksBloc(tasksRepository: context.read<TasksRepository>()),
        )
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

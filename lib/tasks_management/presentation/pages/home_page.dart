import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/generated/l10n.dart';
import 'package:platform_x/tasks_management/application/task/bloc/task_bloc.dart';
import 'package:platform_x/tasks_management/application/task/event/task_event.dart';
import 'package:platform_x/tasks_management/application/task/state/task_state.dart';
import 'package:platform_x/tasks_management/presentation/pages/image_annotation/image_annotation.dart';

import '../../../core/application/theme/bloc/theme_bloc.dart';
import '../../domain/task/task.dart';
import '../components/custom_bottom_bar.dart';
import '../components/homepage_header.dart';
import '../components/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final PageController _scrollController = PageController();

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TasksBloc>(context).add(LoadTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.blue50,
      body: SafeArea(
        child: Container(
          color: context.watch<ThemeBloc>().state.appColorTheme.gray100,
          child: PageView.builder( 
            controller: _pageController,
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == 0){
                return Home(scrollController: _scrollController);
              }
              if (index == 1){
                // return TaskInstructionScreen();
                return AnnotatedImageFormField(
                  imageProvider: AssetImage("assets/task_instruction.png"),
                  onSaved: (value) {
                    print(value);
                  },
                );
              }
              else {
                return Container(child: Center(child: Text(index.toString())),);
              }
              return null;
            }
          ),
        ),
      ),
      // bottomNavigationBar: SizedBox(
      //   width: double.maxFinite,
      //   child: _buildBottomNavigation(context),
      // ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          if (type == BottomBarEnum.Home) {
            _pageController.jumpToPage(0);
          }
          else if (type == BottomBarEnum.Tasks) {
            _pageController.jumpToPage(1);
          }
          else if (type == BottomBarEnum.Wallet) {
            _pageController.jumpToPage(2);
          }
          else if (type == BottomBarEnum.History) {
            _pageController.jumpToPage(3);
          }
          else if (type == BottomBarEnum.Profile) {
            _pageController.jumpToPage(4);
          }
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
    required PageController scrollController,
  }) : _scrollController = scrollController;

  final String description =   "This is very long description for the task at location. For document digitization: Capture images of documents and upload. For document digitization: Capture images of documents and upload.";


  final PageController _scrollController;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: ContentSection(
              controller: _scrollController,
            ),
          ),
        ];
      },
      body: PageView.builder(
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (pageIndex) {},
        controller: _scrollController,
        itemBuilder: (context, pageIndex) {
          return BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              if (state is TasksLoadingState || state is TasksInitialState){
                return const Center(child: CircularProgressIndicator(),);
              }
              else if (state is TasksLoadingSuccessState){
                return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        Task task = state.tasks[index];
                        return  DocumentlistItemWidget(
                          key: Key(index.toString()),
                          task: task,
                          inprogress: pageIndex == 1,
                        );
                      },
                    );
              }

              else {
                return Center(child: Text(S.of(context).t_couldnt_load_try_again));
              }
            }
          );
        },
      ),
    );
  }
}

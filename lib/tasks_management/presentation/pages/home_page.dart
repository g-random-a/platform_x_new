import 'package:flutter/material.dart';
import 'package:platform_x/tasks_management/presentation/pages/task_instruction/task_instruction.dart';

import '../../domain/task/task.dart';
import '../components/custom_bottom_bar.dart';
import '../components/homepage_header.dart';
import '../components/task_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final PageController _scrollController = PageController();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index == 0){
              return Home(scrollController: _scrollController);
            }
            if (index == 1){
              return TaskInstructionScreen();
            }
            else {
              return Container(child: Center(child: Text(index.toString())),);
            }
          }
        ),
        bottomNavigationBar: SizedBox(
          width: double.maxFinite,
          child: _buildBottomNavigation(context),
        ),
      ),
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
        itemCount: 3, // Number of pages in PageView
        onPageChanged: (pageIndex) {},
        controller: _scrollController,
        itemBuilder: (context, pageIndex) {
          return ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return  DocumentlistItemWidget(
                key: Key(index.toString()),
                task: Task(
                        id: "1",
                        title: "For document digitization: Capture images of documents and upload. $index",
                        description: index %2 == 0 ? "This is a description of task $index" : description, // long description
                        // longest desc
                        budget: 250,
                        location: "Addis Ababa",
                        rating: 5,
                        tags: [
                          "18-34+",
                          "Marketing",
                          "Sales",
                          "Business",
                          "Finance",
                          "Accounting",
                          "Management",
                          "Human Resource",
                          "Customer Service",
                          "Information Technology",
                          "Engineering",
                          "Healthcare",
                          "Education",
                        ],
                        totalQuestions: 25,
                        completedQuestions: 5,
            ),
              );
            },
          );
        },
      ),
    );
  }
}

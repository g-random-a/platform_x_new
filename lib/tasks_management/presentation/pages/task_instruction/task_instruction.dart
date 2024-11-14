import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/generated/l10n.dart';
import 'package:platform_x/tasks_management/application/question/bloc/current_answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/bloc/question_bloc.dart';
import 'package:platform_x/tasks_management/application/question/event/current_answer_event.dart';
import 'package:platform_x/tasks_management/application/question/event/question_event.dart';
import 'package:platform_x/tasks_management/application/question/state/question_state.dart';
import 'package:platform_x/tasks_management/domain/task/task.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_image.dart';

import '../../../../core/application/theme/bloc/theme_bloc.dart';
import '../../components/loader_overlay.dart';

class TaskInstructionScreen extends StatefulWidget {
  final Task task;


  const TaskInstructionScreen({super.key, required this.task});

  @override
  State<TaskInstructionScreen> createState() => _TaskInstructionScreenState();
}

class _TaskInstructionScreenState extends State<TaskInstructionScreen> {
  
  Future<void> performTask(BuildContext context) async {
    OverlayLoader.show(context); 
     
    await Future.delayed(Duration(seconds: 3));

    OverlayLoader.hide(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
      body: SafeArea(
        child: BlocListener<QuestionsBloc, QuestionsState>(
          listener: (context, state) {
            
            if (state is QuestionsLoadingSuccessState) {
              OverlayLoader.hide();
              context.go('/tasks/Survey', 
                extra: {
                  'task': widget.task,
                }
              );
            }
            
            else if (state is QuestionsLoadingFailedState) {
              OverlayLoader.hide();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error ?? 'An error occurred while loading questions'),
                  // backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.redA700,
                ),
              );
            }
            
            else if (state is QuestionsLoadingState) {
              OverlayLoader.show(context);
            }
            
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: 'assets/task_instruction.png',
                    border: Border.all(
                      color: context.watch<ThemeBloc>().state.appColorTheme.gray300
                      ),
                    radius: BorderRadius.only(
                      topLeft: Radius.circular(50.h),
                      topRight: Radius.circular(50.h),
                      bottomRight: Radius.circular(50.h)
                    ),
                    height: 320.vh,
                    // width: 314.h,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 16),
                  // Title section
                  Text(
                    // "Financial Access Survey",
                    widget.task.title,
                    style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                    
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // "As part of the survey, we are collecting inputs from various stakeholders, and we are seeking your",
                    widget.task.description,
                    style: CustomTextStyles.bodySmallOnErrorContainer(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Due date section 
                  Row(
                    children: [
                      Icon(Iconsax.calendar_1, size: 14.fSize, color: context.watch<ThemeBloc>().state.appColorTheme.black90001,),
                      const SizedBox(width: 8),
                      Text(
                        // "Due: Oct 29, 2023",
                        widget.task.dueDate != null ? "${widget.task.dueDate!.day}-${widget.task.dueDate!.month}-${widget.task.dueDate!.year} "  : 'No due date',
                        style: CustomTextStyles.bodyMediumInterBlack500(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                          fontSize: 12.25.fSize,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Earnings and Tasks section
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.h),
                      border: Border.all(color: context.watch<ThemeBloc>().state.appColorTheme.gray300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Total Earning
                        Container(
                          padding:  EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                          decoration: BoxDecoration(
                                color: context.watch<ThemeBloc>().state.appColorTheme.blue50,
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).t_total_earning,
                                style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                                  fontSize: 14.fSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${widget.task.budget.toString()}birr.",
                                style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                                  fontSize: 18.fSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Task List
                        Container(
                          padding: EdgeInsets.fromLTRB(16.h, 8.h, 16.h, 4.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).t_total_tasks, 
                                style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                                  fontSize: 14.fSize,
                                  fontWeight: FontWeight.w500,
                                ),),
                              Text(
                                widget.task.totalQuestions.toString(), 
                                style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                                  fontSize: 17.fSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // _buildTaskRow(context, Iconsax.microphone, "Speech generation", 2),
                        // const CustomDivider(),
                        // _buildTaskRow(context, Iconsax.image, "Document digitization", 2),
                        // const CustomDivider(),
                        // _buildTaskRow(context, Iconsax.message, "Annotation and labeling", 2),
                        // SizedBox(height: 4.h,),
                        ...?widget.task.categories?.map(
                          (category) => _buildTaskRow(context, 
                          _getCategoryIcon(category['name']), 
                          category['name'], 
                          category['count'])).toList(),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  SizedBox(height: 20.h),
                  // Start Task Button
                  CustomElevatedButton(
                    backgroundColor: Colors.black,
                    onclick: () async{
                      BlocProvider.of<CurrentAnswerBloc>(context).add(LoadLocalAnswerEvent(taskId: widget.task.id));
                      BlocProvider.of<QuestionsBloc>(context).add(LoadQuestionsEvent(taskId: widget.task.id));
                    },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    if (categoryName.toLowerCase() == "speech generation" || categoryName.toLowerCase().contains('speech') ){
      return Iconsax.microphone;
    }
    else if (categoryName.toLowerCase() == "document digitization" || categoryName.toLowerCase().contains('document') ){
      return Iconsax.image;
    }
    else if (categoryName.toLowerCase() == "annotation and labeling" || categoryName.toLowerCase().contains('annotation') ){
      return Iconsax.message;
    }
    else if (categoryName.toLowerCase() == "image annotation" || categoryName.toLowerCase().contains('image') ){
      return Iconsax.microphone;
    }
    else {
      return Iconsax.document;
    }
  }

  Widget _buildTaskRow(BuildContext context, IconData icon, String taskName, int count) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(width: 8.h), 
          Text(
            taskName, 
            style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                          fontSize: 11.78.fSize,
                          fontWeight: FontWeight.w500,
                          color: context.watch<ThemeBloc>().state.appColorTheme.gray900,
                        ),),
            ],
          ),
          Text(count.toString(),
              style: CustomTextStyles.titleLargePlusJakartaSansBlack900(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
                              fontSize: 11.78.fSize,
                              fontWeight: FontWeight.w500,
                              color: context.watch<ThemeBloc>().state.appColorTheme.gray900,
                            ),),
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double? padding;

  const CustomDivider({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ?? 8.0.h),
      child: Divider(
        color: context.watch<ThemeBloc>().state.appColorTheme.gray300,
        thickness: 1,
      ),
    );
  }
}
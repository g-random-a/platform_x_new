import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/generated/l10n.dart';
import 'package:platform_x/tasks_management/domain/questionTypes.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';
import 'package:platform_x/tasks_management/presentation/components/loader_overlay.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/build_inputs.dart';
import 'package:platform_x/tasks_management/presentation/pages/task_instruction/task_instruction.dart';

import '../../../../core/application/theme/bloc/theme_bloc.dart';

class SurveyScreen extends StatefulWidget {

  final IQuestion question;
  final int currentIndex;
  final int totalQuestions;
  final Function nextPage;
  final Function prevPage;

  const SurveyScreen({super.key, required this.question, required this.currentIndex, required this.totalQuestions, required this.nextPage, required this.prevPage});

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> performTask(BuildContext context) async {
    OverlayLoader.show(context); 
    
    await Future.delayed(Duration(seconds: (widget.totalQuestions * 0.5.round())));

    OverlayLoader.hide(); 

    context.pushReplacement('/tasks/CompeletedSuccessfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 11.h, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: context
                                      .watch<ThemeBloc>()
                                      .state
                                      .appColorTheme
                                      .green700,
                                  borderRadius: BorderRadius.circular(23.61.h),
                                ),
                                child: Text(
                                  // "80% (8/10)",
                                  " ${((widget.currentIndex*100)/widget.totalQuestions).toDoubleValue(fractionDigits: 2)}% (${widget.currentIndex}/${widget.totalQuestions})",
                                  style:
                                      CustomTextStyles.bodyMediumInterBlack500(
                                    context.watch<ThemeBloc>().state.themeData,
                                    context
                                        .watch<ThemeBloc>()
                                        .state
                                        .appColorTheme,
                                  ).copyWith(
                                          color: context
                                              .watch<ThemeBloc>()
                                              .state
                                              .appColorTheme
                                              .whiteA70001),
                                ),
                              ),
                              TextButton(
                                child:  Text(
                                  S.of(context).t_task_compleleted_successfully,
                                  style: CustomTextStyles.labelMediumPoppinsOnErrorContainer(
                                    context.watch<ThemeBloc>().state.themeData, 
                                    context.watch<ThemeBloc>().state.appColorTheme, 
                                    ),
                                  ),
                                onPressed: (){
                                  AlertDialog alertdialog = AlertDialog(
                                    title: Text(S.of(context).t_are_you_sure_dashboard),
                                    content: Text(S.of(context).t_dashboard_progress_lost),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // use go routing
                                          context.pop();
                                        },
                                        child:  Text(S.of(context).t_cancel),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.pushReplacement('/');
                                        },
                                        child:  Text(S.of(context).t_yes),
                                      ),
                                    ],
                                  );

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alertdialog;
                                    }
                                  );
                                }
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          LinearProgressIndicator(
                            value: widget.currentIndex/widget.totalQuestions, // 80% progress
                            backgroundColor: context
                                .watch<ThemeBloc>()
                                .state
                                .appColorTheme
                                .gray30001,
                            color: context
                                .watch<ThemeBloc>()
                                .state
                                .appColorTheme
                                .green700,
                            minHeight: 8.vh,
                            borderRadius: BorderRadius.circular(30.h),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.currentIndex.toString(),
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            // "How much do you agree with the following statement: "
                            // "\"I find it easy to use mobile apps for work-related tasks.\"",
                            widget.question.text,
                            style: CustomTextStyles.bodyMediumInterBlack500(
                              context.watch<ThemeBloc>().state.themeData,
                              context.watch<ThemeBloc>().state.appColorTheme,
                            ).copyWith(
                              fontSize: 20.fSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    children: [
                                      ...buildInputs(context, 
                                      widget.question.inputs
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                      height:
                                          20), // Added spacing to ensure proper padding
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const CustomDivider(
                    padding: 0,
                  ),
                  SizedBox(height: 20.h),
                  CustomElevatedButton(
                    onclick: () {
                      FocusScope.of(context).unfocus();
                      
                      if (_formKey.currentState != null) {
                        bool valid = _formKey.currentState!.validate();
                        if (valid){
                          if (widget.currentIndex == widget.totalQuestions){
                            performTask(context);

                          }
                          else {
                            widget.nextPage();
                          }
                        }
                      }
                    },
                    text: widget.currentIndex == widget.totalQuestions ? S.of(context).t_submit : S.of(context).t_next,
                    backgroundColor: context
                        .watch<ThemeBloc>()
                        .state
                        .appColorTheme
                        .black90001,
                    textColor: context
                        .watch<ThemeBloc>()
                        .state
                        .appColorTheme
                        .whiteA70001,
                  ),
                  const SizedBox(height: 10), // Add spacing between buttons
                  CustomElevatedButton(
                    onclick: () {
                      FocusScope.of(context).unfocus();

                      widget.prevPage();
                    },
                    text: S.of(context).t_previous,
                    backgroundColor: context
                        .watch<ThemeBloc>()
                        .state
                        .appColorTheme
                        .whiteA70001,
                    textColor: context
                        .watch<ThemeBloc>()
                        .state
                        .appColorTheme
                        .black90001,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

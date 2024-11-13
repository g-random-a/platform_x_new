import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/generated/l10n.dart';
import 'package:platform_x/tasks_management/application/question/bloc/answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/bloc/current_answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/event/answer_event.dart';
import 'package:platform_x/tasks_management/application/question/state/answer_state.dart';
import 'package:platform_x/tasks_management/application/question/state/current_answer_state.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/domain/questionTypes.dart';
import 'package:platform_x/tasks_management/domain/task/task.dart';
import 'package:platform_x/tasks_management/domain/task/task_question_map.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';
import 'package:platform_x/tasks_management/presentation/components/loader_overlay.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/audio_input_builder.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/build_inputs.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/checkbox_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/color_picker.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/date_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/dropdown_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/email_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/file_media_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/number_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/radiobox_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/range_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/rating_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/signiture_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/slider_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/time_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/photo_taker.dart';
import 'package:platform_x/tasks_management/presentation/pages/task_instruction/task_instruction.dart';
import 'package:platform_x/tasks_management/services/hive/answermanagment.dart';
import 'package:platform_x/tasks_management/services/hive/taskmanagment.dart';

import '../../../../core/application/theme/bloc/theme_bloc.dart';
import '../../../application/question/event/current_answer_event.dart';
import 'components/inputTypes/text_input.dart';

class SurveyScreen extends StatefulWidget {

  final IQuestion question;
  final int currentIndex;
  final int totalQuestions;
  final Function nextPage;
  final Function prevPage;
  final Task task;

  const SurveyScreen({super.key, required this.question, required this.currentIndex, required this.totalQuestions, required this.nextPage, required this.prevPage, required this.task});

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();

  List<GlobalKey> globalKeys = [];

  void addGlobalKey(GlobalKey key) {
    globalKeys.add(key);
  }

  // Future<void> performTask(BuildContext context) async {
  //   OverlayLoader.show(context); 
    
  //   await Future.delayed(Duration(seconds: (widget.totalQuestions * 0.5.round())));

  //   OverlayLoader.hide(); 

  //   context.pushReplacement('/tasks/CompeletedSuccessfully');
  // }

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
                                  S.of(context).t_back_to_main_screen,
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
                                          context.pop();
                                        },
                                        child:  Text(S.of(context).t_cancel),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          widget.task.completedQuestions = widget.currentIndex-1;
                                          widget.task.totalQuestions = widget.totalQuestions;
                                          await context.read<TaskManagerService>().saveTask(widget.task);
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
                            autovalidateMode: AutovalidateMode.always,
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
                                      widget.question.inputs,
                                      widget.question.id ?? "",
                                      addGlobalKey,
                                      ),
                                      // // RatingInputField(properties: RatingPropertySchema(maximumRating: 10, minimumRating: 0, label: "Rate your exp on this question"), validations: RatingInputValidationSchema(required: true)),
                                      // // SketchFormField(
                                      // //   validations: SignatureInputValidationSchema(required: true),
                                      // //   properties: SignaturePropertySchema(),
                                      // // ),

                                      // // TEST INPUT -- V01
                                      // // 1. PHOTO TAKER
                                      // TakePhotoComponent(
                                      //   properties:  MediaPropertySchema(mediaType: 'imgae', label: 'Take a selfie of yourself',), 
                                      //   validations: MediaInputValidationSchema(required: true),
                                      //   inputId: 1,
                                      //   questionId: widget.question.id ?? "",
                                        
                                      //   ),

                                      // // 2. AUDIO RECORDER and uploader
                                      // AudioInputBuilder(
                                      //   property: MediaPropertySchema(mediaType: "Audio", label: "Record your voice reading the question in AMHARIC Language.",),
                                      //   validation: MediaInputValidationSchema(required: true),
                                      //   inputId: 2,
                                      //   questionId: widget.question.id ?? "",
                                      // ),

                                      // // 3. MediaFileInputField
                                      // MediaFileInputField(
                                      //   properties: MediaPropertySchema(mediaType: 'FILE'), 
                                      //   validation: MediaInputValidationSchema(required: true),
                                      //   inputId: 3,
                                      //   questionId: widget.question.id ?? "",
                                      //   ),

                                      // // 4. Checkbox InputField
                                      // CheckboxInputField(
                                      //   properties: CheckboxPropertySchema(
                                      //     options: [
                                      //       InputOptions(id: 1, value: "USA", valueType: "String"),
                                      //       InputOptions(id: 1, value: "Kenya", valueType: "String"),
                                      //       InputOptions(id: 1, value: "Ethiopia", valueType: "String"),
                                      //       InputOptions(id: 1, value: "Eritria", valueType: "String"),
                                      //       InputOptions(id: 1, value: "Canada", valueType: "String"),
                                      //       InputOptions(id: 1, value: "None", valueType: "String"),
                                      //     ],
                                      //     type: 'string',
                                      //     label: 'Select your country of residence',
                                      //     ), validations: CheckboxInputValidationSchema(required: true),
                                      //     questionId: widget.question.id ?? '', inputId: 4)

                                      // // 5. ColorPickerInputField
                                      // // ColorPickerInputField(
                                      // //   properties: ColorPickerPropertySchema(label: 'Select your favorite color'),
                                      // //   validations: ColorPickerInputValidationSchema(required: true),
                                      // // ),

                                      // // 6. DateInputField
                                      // // DateInputField(
                                      // //   properties: DatePropertySchema(label: 'Select your date of birth'),
                                      // //   validations: DateInputValidationSchema(required: true),
                                      // // ),

                                      // // 7. DropdownInputField
                                      // ,
                                      // DropdownInputField(
                                      //   properties: DropdownPropertySchema(
                                      //     options: [
                                      //       InputOptions(id: 1, value: "USA", valueType: "String"),
                                      //       InputOptions(id: 2, value: "Kenya", valueType: "String"),
                                      //       InputOptions(id: 3, value: "Ethiopia", valueType: "String"),
                                      //       InputOptions(id: 4, value: "Eritria", valueType: "String"),
                                      //       InputOptions(id: 5, value: "Canada", valueType: "String"),
                                      //       InputOptions(id: 6, value: "None", valueType: "String"),
                                      //     ],
                                      //     label: 'Select your country of residence',
                                      //     ), validations: DropdownInputValidationSchema(required: true),
                                      //     questionId: widget.question.id ?? '', inputId: 7,
                                      //     ),

                                      // // 8. EmailInputField
                                      // // EmailInputField(
                                      // //   properties: EmailPropertySchema(label: 'Enter your email address', suffix: "@gmail.com"),
                                      // //   validation: EmailInputValidationSchema(required: true),
                                      // // ),

                                      // // 9. NumberInputField
                                      // // NumberInputField(
                                      // //   properties: NumberPropertySchema(label: 'Enter your age'),
                                      // //   validations: NumberInputValidationSchema(required: true),
                                      // // ),

                                      // // 10. RadioboxInputField
                                      // RadioboxInputField(
                                      //   properties: RadioPropertySchema(
                                      //     options: [
                                      //       InputOptions(id: 1, value: "USA", valueType: "String"),
                                      //       InputOptions(id: 1, value: "Kenya", valueType: "String"),
                                      //       InputOptions(id: 1, value: "Ethiopia", valueType: "String"),
                                      //       InputOptions(id: 1, value: "Eritria", valueType: "String"),
                                      //       InputOptions(id: 1, value: "Canada", valueType: "String"),
                                      //       InputOptions(id: 1, value: "None", valueType: "String"),
                                      //     ],
                                      //     label: 'Select your country of residence',
                                      //     ), validations: RadioInputValidationSchema(required: true), questionId: widget.question.id ?? '', inputId: 10,),

                                      // // 11. RangeInputField
                                      // // RangeInputField(
                                      // //   properties: RangePropertySchema(label: 'Select your age range', min: 1, max: 10),
                                      // //   validations: RangeInputValidationSchema(required: true),
                                      // //   in
                                      // // ),

                                      // // 12. RatingInputField 
                                      // RatingInputField(
                                      //   properties: RatingPropertySchema(label: 'Rate your experience on this question', maximumRating: 10, minimumRating: 0),
                                      //   validations: RatingInputValidationSchema(required: false), inputId: 12, questionId: widget.question.id ?? "",
                                      // ),

                                      // // 13. SignatureInputField
                                      // // SketchFormField(
                                      // //   properties: SignaturePropertySchema(label: 'Sign here'),
                                      // //   validations: SignatureInputValidationSchema(required: true),
                                      // // ),

                                      // // 14. SliderInputField
                                      // SliderInputField(
                                      //   properties: SliderPropertySchema(label: 'Select your age', min: 1, max: 10),
                                      //   validations: SliderInputValidationSchema(required: true), questionId: widget.question.id ?? "", inputId: 14,
                                      // ),

                                      // // 15. TextInputField
                                      // TextInputField(
                                      //   properties: TextPropertySchema(label: 'Enter your name'),
                                      //   validations: TextInputValidationSchema(required: true),
                                      //   questionId: widget.question.id ?? "", inputId: 15,
                                      // ),

                                      // 16. TimeInputField
                                      // TimeInputField(isRequired: false)




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
                  BlocConsumer<AnswerBloc, AnswerState>(
                    listener: (context, finAnsState) async {
                      if (finAnsState is AnswerLoadingState){
                        OverlayLoader.show(context); 
                        return;
                      }

                      
                      if (finAnsState is AnswerSubmitionFailedState) {
                        // show snacbar
                        OverlayLoader.hide(); 
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("failed to save answer, please try again."),
                          ),
                        );

                      }

                      if (finAnsState is AnswerSubmittedState){
                        TaskManagerService tms = context.read<TaskManagerService>();
                        AnswerManagement am = context.read<AnswerManagement>();

                        TaskQuestionMap? questionsMap = tms.getTaskQuestionMap(widget.task.id);

                        if (questionsMap != null) await am.deleteAnswers(questionsMap.questionId);

                        await context.read<TaskManagerService>().deleteTask(widget.task.id, both: true );

                        OverlayLoader.hide(); 
                        context.pushReplacement('/tasks/CompeletedSuccessfully');
                      }


                    },
                        builder: (context, finAnsState) {
                      return BlocConsumer<CurrentAnswerBloc, CurrentAnswerState>(
                        listener: (context, state) {
                          if (state is CurrentAnswerSubmitionFailedState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("failed to save answer, please try again."),
                              ),
                            );
                          }
                          if (state is CurrentAnswerSubmittedState){
                            if (widget.currentIndex == widget.totalQuestions){
                              // performTask(context);
                              BlocProvider.of<AnswerBloc>(context).add(SubmitAnswerEvent(taskId: widget.task.id));
                            }else {
                              widget.nextPage();
                            }
                          }
                        },
                        builder: (context, state) {
                          return CustomElevatedButton(
                            loading: state is CurrentAnswerLoadingState,
                            onclick: () {
                              FocusScope.of(context).unfocus();
                              
                              if (_formKey.currentState != null) {
                                bool valid = _formKey.currentState!.validate();
                                if (valid){
                                    BlocProvider.of<CurrentAnswerBloc>(context).add(SubmitCurrentAnswerEvent(questionId: widget.question.id ?? "", taskId: widget.task.id));
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
                          );
                        }
                      );
                    }
                  ),
                  const SizedBox(height: 10), // Add spacing between buttons
                  if (widget.currentIndex != 1)
                  BlocBuilder<CurrentAnswerBloc, CurrentAnswerState>(
                    builder: (context,state) {
                      return CustomElevatedButton(
                        disabled: state is CurrentAnswerLoadingState,
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
                      );
                    }
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


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_image.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/audio_input_builder.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/color_picker.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/date_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/dropdown_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/email_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/later_media_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/number_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/radiobox_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/range_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/slider_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/time_input.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/photo_taker.dart';
import 'package:platform_x/tasks_management/presentation/pages/task_instruction/task_instruction.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/audio_recoder_picker.dart';

import '../../../../core/application/theme/bloc/theme_bloc.dart';
import '../../../domain/inputPropertiesType.dart';
import 'components/inputTypes/checkbox_input.dart';
import 'components/inputTypes/text_input.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {

  final _formKey = GlobalKey<FormState>();

  String? selectedOption;
  final selectBoxOptions = [
                                      {
                                        "value": "Extra Neutral",
                                        "selected": false
                                      },
                                      {
                                        "value": "Strongly Agree",
                                        "selected": false,
                                      },
                                      {
                                        "value": "Agree",
                                        "selected": false
                                      },
                                      {
                                        "value": "Neutral",
                                        "selected": false
                                      }
                                    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
      body: GestureDetector(
        onTap: (){
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
                                padding: EdgeInsets.symmetric(horizontal: 11.h, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: context.watch<ThemeBloc>().state.appColorTheme.green700,
                                  borderRadius: BorderRadius.circular(23.61.h),
                                ),
                                child: Text("80% (8/10)", 
                                style: CustomTextStyles.bodyMediumInterBlack500(context.watch<ThemeBloc>().state.themeData,
                                context.watch<ThemeBloc>().state.appColorTheme,).copyWith(
                                  color: context.watch<ThemeBloc>().state.appColorTheme.whiteA70001
                                ),
                                ),
                              ),
                              Container(
                                child: Text("Back to Dash"),
                              ),
                            ],
                           ),
                           SizedBox(height: 10.h),
                            LinearProgressIndicator(
                              value: 0.8, // 80% progress
                              backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.gray30001,
                              color: context.watch<ThemeBloc>().state.appColorTheme.green700,
                              minHeight: 8.vh,
                              borderRadius: BorderRadius.circular(30.h),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "O1",
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "How much do you agree with the following statement: "
                              "\"I find it easy to use mobile apps for work-related tasks.\"",
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
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    children: [
                                      // Question files section
                                    
                                      // _buildOption("Strongly Agree"),
                                      // _buildOption("Agree"),
                                      // _buildOption("Neutral"),
                                      // _buildOption("Disagree"),
                                      // _buildOption("Strongly Disagree"),
                                      // _buildOption("Applicable"),
                                      // _buildOption("Applicable"),
                                      // _buildOption("Applicable"),
                                      // _buildOption("Applicable"),
                                      // AudioPlayerWidget(),
                                      // AudioMessageComponent(sender: "jenny", audioPath: "", time: "2:30",),
                                      // CustomImageView(
                                      //   imagePath: "",
                                      //   fit: BoxFit.fill,
                                      //   height: 400.h,
                                    
                                      // ),
                                      // TakePhotoComponent(),
                                      // TakePhotoComponent(),
                                      // VoiceMessageWidget(audioUrl: "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3", isFile: false, onPause: (){print("paused");}, onPlaying: (){print("playing");}, isRecorded: true,),
                                      // VoiceMessageWidget(audioUrl: "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3", isFile: false, onPause: (){print("paused");}, onPlaying: (){print("playing");}, isRecorded: true,),
                                      // VoiceMessageWidget(audioUrl: "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3", isFile: false, onPause: (){print("paused");}, onPlaying: (){print("playing");}, isRecorded: false,),
                                      // VoiceMessageWidget(audioUrl: "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3", isFile: false, onPause: (){print("paused");}, onPlaying: (){print("playing");}, isRecorded: false,),
                                      // VoiceMessageWidget(audioUrl: "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3", isFile: false, onPause: (){print("paused");}, onPlaying: (){print("playing");}, isRecorded: false,),
                                      // VoiceMessageWidget(audioUrl: "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3", isFile: false, onPause: (){print("paused");}, onPlaying: (){print("playing");}, isRecorded: false,),
                                      // VoiceMessageWidget(audioUrl: "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3", isFile: false, onPause: (){print("paused");}, onPlaying: (){print("playing");}, isRecorded: false,),
                                      // VoiceMessageWidget(audioUrl: "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3", isFile: false, onPause: (){print("paused");}, onPlaying: (){print("playing");}, isRecorded: false,),
                                      // VoiceMessageWidget(audioUrl: "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3", isFile: false, onPause: (){print("paused");}, onPlaying: (){print("playing");}, isRecorded: false,),
                                      // VoiceMessageWidget(audioUrl: "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3", isFile: false, onPause: (){print("paused");}, onPlaying: (){print("playing");}, isRecorded: false,),
                                      // TextInputField(properties: TextPropertySchema(label: "Rice (Kg)", placeholder: "100", defaultValue: "200"), validations: TextInputValidationSchema(required: true) ),
                                      // NumberInputField(properties: NumberPropertySchema(label: "countries in afric"), validations: NumberInputValidationSchema(required: true, allowDecimal: true)),
                                      // CheckboxInputField(properties: CheckboxPropertySchema(type: "Text", values: selectBoxOptions,
                                      // label: "Your Emotion About Ethiopian Democracy"
                                      // ), validations: CheckboxInputValidationSchema(required: true),),
                                      // RadioboxInputField(properties: RadioPropertySchema(options: selectBoxOptions,
                                      // label: "Your Emotion About Ethiopian Democracy"
                                      // ), validations: RadioInputValidationSchema(required: true),),
                                      // ColorPickerInputField(
                                      //   properties: ColorPickerPropertySchema(label: "Pick a color"),
                                      //   validations: ColorPickerInputValidationSchema(required: true)),
                                      // TimeInputField(isRequired: true),
                                      // SliderInputField(min: 0, max: 10, isRequired: true, step: 2,),
                                      // ColorPickerInputField(
                                      //   properties: ColorPickerPropertySchema(label: "Pick a color"),
                                      //   validations: ColorPickerInputValidationSchema(required: true)
                                      // ),

                                      // testing phase
                                      
                                      // DateInputField(
                                      //   property: DatePropertySchema(),
                                      //   validation: DateInputValidationSchema(required: true),
                                      // )
                                      // DropdownInputField(
                                      //   property: DropdownPropertySchema(
                                      //     options: ["Extra Neutral", "Strongly Agree", "Agree", "Neutral"],
                                      //     placeholder: "Select an option",
                                      //     // defaultValue: "Extra Neutral"
                                      //   ),
                                      //   validation: DropdownInputValidationSchema(required: true)
                                      // ),
                                      // EmailInputField(
                                      //   validation: EmailInputValidationSchema(required: true),
                                      //   properties: EmailPropertySchema(label: "Enter your email adress", placeholder: "example@mail.com",)
                                      // )

                                      // NumberInputField(
                                      //   validations: NumberInputValidationSchema(required: true),
                                      //   properties: NumberPropertySchema(label: "Enter your age", defaultValue: 25,)
                                      // )

                                      // RadioboxInputField(
                                      //   properties: RadioPropertySchema(
                                      //     options: [
                                      //       {
                                      //         "id": 1,
                                      //         "value": "Extra Neutral",
                                      //         "selected": false
                                      //       },
                                      //       {
                                      //         "id": 2,
                                      //         "value": "Strongly Agree",
                                      //         "selected": false,
                                      //       },
                                      //       {
                                      //         "id": 3,
                                      //         "value": "Agree",
                                      //         "selected": false
                                      //       },
                                      //       {
                                      //         "id": 4,
                                      //         "value": "Neutral",
                                      //         "selected": false
                                      //       }
                                      //     ],
                                      // ),
                                      //   validations: RadioInputValidationSchema(required: true),
                                      // ),

                                      // RangeInputField(
                                      //   properties: RangePropertySchema(min: 0, max: 15, label: "Select a range", step: 1),
                                      //   validations: RangeInputValidationSchema(required: true),
                                      // ),

                                      // SliderInputField(
                                      //   properties: SliderPropertySchema(min: 2, max: 5, label: "select the best option for age"),
                                      //   validations: SliderInputValidationSchema(required: true),
                                      //   ),

                                      TakePhotoComponent(
                                        properties: MediaPropertySchema(
                                          mediaType: "image",
                                          label: "Take a photo of yourself",
                                          ),
                                        validations: MediaInputValidationSchema(required: true, ),
                                      ),
                                      TextInputField(
                                        properties: TextPropertySchema(
                                          label: "Enter a caption for the image",
                                          placeholder: "John Doe",
                                          defaultValue: "John Doe",
                                          suffix: ""

                                        ),
                                        validations: TextInputValidationSchema(required: true),
                                      ),

                                      AudioInputBuilder(
                                        validation: MediaInputValidationSchema(required: true)
                                      , property: MediaPropertySchema(mediaType: "audio"))

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
                  const CustomDivider(padding: 0,),
                  // AudioPlayerWidget(),
                  SizedBox(height: 20.h),
                  CustomElevatedButton(
                    onclick: () {
                      // submit the form
                      // if (_formKey.currentState!.validate()) 
                      if ( _formKey.currentState != null) _formKey.currentState!.validate();
                      print("---------------------------------------------------------------------");
                      print(_formKey.currentState!.validate());
                    },
                    text: "Next",
                    backgroundColor:
                        context.watch<ThemeBloc>().state.appColorTheme.black90001,
                    textColor:
                        context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
                  ),
                  const SizedBox(height: 10), // Add spacing between buttons
                  CustomElevatedButton(
                    onclick: () {},
                    text: "Previous",
                    backgroundColor:
                        context.watch<ThemeBloc>().state.appColorTheme.whiteA70001,
                    textColor:
                        context.watch<ThemeBloc>().state.appColorTheme.black90001,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildOption(String option) {
  //   return RadioListTile<String>(
  //     title: Text(option),
  //     value: option,
  //     groupValue: selectedOption,
  //     onChanged: (value) {
  //       setState(() {
  //         selectedOption = value;
  //       });
  //     },
  //   );
  // }

  Widget _buildOption(String option) {
    bool isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = isSelected ? null : option;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 3.6.h),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        height: 47.vh,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.h),
          border: Border.all(
            color: isSelected
                ? context.watch<ThemeBloc>().state.appColorTheme.green200
                : context.watch<ThemeBloc>().state.appColorTheme.gray90001,
            width: 0.54.h,
          ), // Border color changes based on selection
          color: isSelected
              ? Colors.green[100]
              : Colors.transparent, // Background color for selected
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (bool? value) {
                setState(() {
                  selectedOption = value == true ? option : null;
                });
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: isSelected
                        ? context
                            .watch<ThemeBloc>()
                            .state
                            .appColorTheme
                            .green200
                        : context
                            .watch<ThemeBloc>()
                            .state
                            .appColorTheme
                            .gray90001,
                    style: BorderStyle.solid),
              ),
              activeColor: Colors.green,
              checkColor: Colors.white,
            ),
            Text(
              option,
              style: CustomTextStyles.titleRedHatDisplayOnGray90001(
                      context.watch<ThemeBloc>().state.themeData,
                      context.watch<ThemeBloc>().state.appColorTheme)
                  .copyWith(
                color: selectedOption == option
                    ? context.watch<ThemeBloc>().state.appColorTheme.green700
                    : context.watch<ThemeBloc>().state.appColorTheme.gray90001,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

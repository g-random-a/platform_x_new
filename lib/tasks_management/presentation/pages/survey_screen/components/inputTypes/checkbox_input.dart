import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/tasks_management/application/question/bloc/current_answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/event/current_answer_event.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';

import '../../../../../../core/application/theme/bloc/theme_bloc.dart';
import '../../../../../../core/utils/theme/custom_text_styles.dart';

class CheckboxInputField extends StatefulWidget {

  final CheckboxInputValidationSchema validations;
  final CheckboxPropertySchema properties;
  final int inputId;
  final String questionId;

  const CheckboxInputField({
    super.key,
    required this.properties,
    required this.validations, 
    required this.inputId,  
    required this.questionId,
  });

  @override
  _CheckboxInputFieldState createState() => _CheckboxInputFieldState();
}

class _CheckboxInputFieldState extends State<CheckboxInputField> {

  Map<String, Object> selectedOptions = {};

  void _initFromLocal(){
    final SelectionAnswer? answer = BlocProvider.of<CurrentAnswerBloc>(context).state.answers[widget.questionId + "_" + widget.inputId.toString()] as SelectionAnswer?;
    print("----------------------------------------------------------------");
    print("----------------------------------------------------------------");
    print(answer);
    print(BlocProvider.of<CurrentAnswerBloc>(context).state.answers);
    print(BlocProvider.of<CurrentAnswerBloc>(context).state.answers);
    print("${widget.questionId}, ${widget.inputId}");
    print("----------------------------------------------------------------");
    print("----------------------------------------------------------------");

    if (answer != null) {
      setState(() {
      widget.properties.options = answer.selected;
      answer.selected.forEach((element) {
        if (element.selected) selectedOptions[element.value] = element.selected;
      });
      });
  }
  }

  @override
  void initState() {
    super.initState();
    _initFromLocal();
  }

  String? validateCheckbox(String? value) {
    if (widget.validations.required && selectedOptions.isEmpty){ 
      return widget.validations.customErrorMessage ?? 'This field is required';
    }

    if (widget.validations.minSelection != null && selectedOptions.length < widget.validations.minSelection!){
      return 'Please select at least ${widget.validations.minSelection} options';
    }

    if (widget.validations.maxSelection != null && selectedOptions.length > widget.validations.maxSelection!){
      return 'Please select at most ${widget.validations.maxSelection} options';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validateCheckbox,
      builder: (field) {
        return Column(
          children: 
            [
              if(widget.properties.label != null && widget.properties.label!.isNotEmpty) Text(
                widget.properties.label!,
                style: CustomTextStyles.bodySmallPlusJakartaSansBlack90001(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
              ),
              ...List.generate(widget.properties.options.length, 
        (index) => 
           GestureDetector(
          onTap: () {
            setState(() {
              bool val = !(widget.properties.options[index].selected);
              widget.properties.options[index].selected = val;
              selectedOptions[widget.properties.options[index].value] = val;
              BlocProvider.of<CurrentAnswerBloc>(context).add(UpdateCurrentAnswerEvent(answer: SelectionAnswer(
                      id: widget.inputId, 
                      selected: widget.properties.options, 
                    ), questionId: widget.questionId, ));
              if (val == false){
                selectedOptions.remove(widget.properties.options[index].value);
              }

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
                color: widget.properties.options[index].selected == true
                    ? context.watch<ThemeBloc>().state.appColorTheme.green200
                    : context.watch<ThemeBloc>().state.appColorTheme.gray90001,
                width: 0.54.h,
              ), // Border color changes based on selection
              color: widget.properties.options[index].selected == true
                  ? Colors.green[100]
                  : Colors.transparent, // Background color for selected
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: widget.properties.options[index].selected == true,
                  onChanged: (bool? value) {
                    bool val = !(widget.properties.options[index].selected as bool);
                    BlocProvider.of<CurrentAnswerBloc>(context).add(UpdateCurrentAnswerEvent(answer: SelectionAnswer(
                      id: widget.inputId, 
                      selected: widget.properties.options, 
                    ), questionId: widget.questionId, ));
                    setState(() {
                      selectedOptions[widget.properties.options[index].value] = val;
                      if (val == false){
                        selectedOptions.remove(widget.properties.options[index].value);
                      }
                      widget.properties.options[index].selected = val ;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: widget.properties.options[index].selected == true
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
                  activeColor: context.watch<ThemeBloc>().state.appColorTheme.green700,
                  checkColor: context.watch<ThemeBloc>().state.appColorTheme.whiteA700,
                ),
                Text(
                  widget.properties.options[index].value,
                  style: CustomTextStyles.titleRedHatDisplayOnGray90001(
                          context.watch<ThemeBloc>().state.themeData,
                          context.watch<ThemeBloc>().state.appColorTheme)
                      .copyWith(
                    color: widget.properties.options[index].selected == true
                        ? context.watch<ThemeBloc>().state.appColorTheme.green700
                        : context.watch<ThemeBloc>().state.appColorTheme.gray90001,
                  ),
                ),
              ],
            ),
          ),
        )
        ),

        if (field.hasError) ...[
          const SizedBox(height: 8),
          Text(
            field.errorText ?? '',
            style: const TextStyle(color: Colors.red),
          ),
        ],
        ]
        );
      }
    );
}
}

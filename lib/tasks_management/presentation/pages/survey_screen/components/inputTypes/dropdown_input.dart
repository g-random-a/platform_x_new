import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/tasks_management/application/question/bloc/current_answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/event/current_answer_event.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';

class DropdownInputField extends StatefulWidget {
  
  final DropdownInputValidationSchema validations;
  final DropdownPropertySchema properties;
  final String questionId;
  final int inputId;

  const DropdownInputField({
    super.key,
    required this.validations,
    required this.properties,
    required this.questionId,
    required this.inputId,
  });

  @override
  State<DropdownInputField> createState() => _DropdownInputFieldState();
}

class _DropdownInputFieldState extends State<DropdownInputField> {
  
  InputOptions? selectedValue;
  
  String? validateDropdown(InputOptions? value) {
    if (widget.validations.required && value == null) {
      return widget.validations.customErrorMessage ?? 'Please select an option';
    }
    return null;
  }

  void _initFromLocal(){
    final SelectionAnswer? answer = BlocProvider.of<CurrentAnswerBloc>(context).state.answers[widget.questionId + "_" + widget.inputId.toString()] as SelectionAnswer?;

    if (answer != null && answer.selected.isNotEmpty) {
      setState(() {
      selectedValue = answer.selected[0];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _initFromLocal();
  }

  @override
  Widget build(BuildContext context) {
 
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          widget.properties.label != null ? Text(widget.properties.label ?? '', style: CustomTextStyles.labelLargePlusJakartaSans(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme)) : Container(),
          DropdownButtonFormField<InputOptions>(
            value: selectedValue,
            hint: Text(widget.properties.placeholder ?? 'Select an option'),
            items: widget.properties.options.map((value) {
              return DropdownMenuItem<InputOptions>(
                value: value,
                enabled: true,
                child: Text(value.value),
              );
            }).toList(),
            onChanged: (InputOptions? newValue) {
              if (newValue != null){
                setState(() {
                  selectedValue = newValue;
                });
                BlocProvider.of<CurrentAnswerBloc>(context).add(UpdateCurrentAnswerEvent(answer: SelectionAnswer(
                      id: widget.inputId, 
                      selected: [newValue], 
                    ), questionId: widget.questionId, ));
              }
            },
            validator: validateDropdown,
            style: CustomTextStyles.labelLargePlusJakartaSans(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.h),
                borderSide: BorderSide(color: context.watch<ThemeBloc>().state.themeData.secondaryHeaderColor)
              ),
               focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.h),
                borderSide: BorderSide(color: context.watch<ThemeBloc>().state.appColorTheme.green700)
              ),
          
            ),
          ),
        ],
      ),
    );
  }
}

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

class RadioboxInputField extends StatefulWidget {
  final RadioInputValidationSchema validations;
  final RadioPropertySchema properties;
  final String questionId;
  final int inputId;

  const RadioboxInputField({
    super.key,
    required this.properties,
    required this.validations,
    required this.questionId,
    required this.inputId,

  });

  @override
  _RadioboxInputFieldState createState() => _RadioboxInputFieldState();
}

class _RadioboxInputFieldState extends State<RadioboxInputField> {
  int? selectedValue;

  void _initFromLocal(){
    final SelectionAnswer? answer = BlocProvider.of<CurrentAnswerBloc>(context).state.answers[widget.questionId + "_" + widget.inputId.toString()] as SelectionAnswer?;

    if (answer != null) {
      setState(() {
      widget.properties.options = answer.selected;
      selectedValue = widget.properties.options.indexWhere((element) => element.selected == true);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initFromLocal();
  }

  String? validateCheckbox(bool? value) {
    if (widget.validations.required && selectedValue == null) {
      return widget.validations.customErrorMessage ?? 'This field is required';
    }
    return null;
  }
 
  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      validator: validateCheckbox,

      builder: (FormFieldState<bool> field) {
        return Column(children: [
          if (widget.properties.label != null &&
              widget.properties.label!.isNotEmpty)
            Text(
              widget.properties.label!,
              style: CustomTextStyles.bodySmallPlusJakartaSansBlack90001(
                  context.watch<ThemeBloc>().state.themeData,
                  context.watch<ThemeBloc>().state.appColorTheme),
            ),
          ...List.generate(
              widget.properties.options.length,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.properties.options[index].selected = !(widget
                            .properties.options[index].selected);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.h, vertical: 3.6.h),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.h),
                        border: Border.all(
                          color: widget.properties.options[index].selected ==
                                  true
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
                          width: 0.54.h,
                        ),
                        color:
                            widget.properties.options[index].selected == true
                                ? Colors.green[100]
                                : Colors.transparent,
                      ),
                      child: Center(
                        child: RadioListTile<bool>(
                          value: widget.properties.options[index].selected ==
                              true,
                          onChanged: (bool? value) {
                            if (selectedValue != null) {
                                widget.properties.options[selectedValue!]
                                    .selected = false;
                              }
                            widget.properties.options[index].selected =
                                !(widget.properties.options[index].selected
                                    as bool);
                            BlocProvider.of<CurrentAnswerBloc>(context).add(UpdateCurrentAnswerEvent(answer: SelectionAnswer(
                              id: widget.inputId, 
                              selected: widget.properties.options, 
                            ), questionId: widget.questionId, ));
                            setState(() {
                              selectedValue = index;
                            });
                          },
                          toggleable: true,
                          activeColor: Colors.green,
                          groupValue: true,
                          title: Text(
                            widget.properties.options[index].value as String,
                            style:
                                CustomTextStyles.titleRedHatDisplayOnGray90001(
                                        context
                                            .watch<ThemeBloc>()
                                            .state
                                            .themeData,
                                        context
                                            .watch<ThemeBloc>()
                                            .state
                                            .appColorTheme)
                                    .copyWith(
                              color: widget.properties.options[index]
                                          .selected ==
                                      true
                                  ? context
                                      .watch<ThemeBloc>()
                                      .state
                                      .appColorTheme
                                      .green700
                                  : context
                                      .watch<ThemeBloc>()
                                      .state
                                      .appColorTheme
                                      .gray90001,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (selectedValue != null)
                TextButton(
                  onPressed: () {
                    widget.properties.options[selectedValue!].selected =
                          false;

                    BlocProvider.of<CurrentAnswerBloc>(context).add(UpdateCurrentAnswerEvent(answer: SelectionAnswer(
                        id: widget.inputId, 
                        selected: widget.properties.options, 
                      ), questionId: widget.questionId, ));


                    setState(() {
                      selectedValue = null;
                    });


                    // Form.of(context).validate();
                  },
                  child: const Text('Clear selection'),
                ),
            ],
          ),
               if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    field.errorText ?? '',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
        ]);
      },
    );
  }
}

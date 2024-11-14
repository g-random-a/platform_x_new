import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/tasks_management/application/question/bloc/current_answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/event/current_answer_event.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_rating_bar.dart';

class RatingInputField extends StatefulWidget {

  final RatingInputValidationSchema validations;
  final RatingPropertySchema properties;
  final String questionId;
  final int inputId;

  const RatingInputField({
    super.key,
    required this.validations,
    required this.properties,
    required this.inputId,
    required this.questionId,
  });

  @override
  _RatingInputFieldState createState() => _RatingInputFieldState();
}

class _RatingInputFieldState extends State<RatingInputField> {
  double? ratingValue;

  void _initFromLocal(){
    final ValueAnswer? answer = BlocProvider.of<CurrentAnswerBloc>(context).state.answers[widget.questionId + "_" + widget.inputId.toString()] as ValueAnswer?;

    if (answer != null) {
      setState(() {
      ratingValue = double.tryParse(answer.value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.properties.defaultRating != null) ratingValue = widget.properties.defaultValue?.toDouble();
    _initFromLocal();
  }

  String? validateRating(double? value) {
    // if (widget.validations.required && value == null) {
    //   return widget.validations.customErrorMessage ?? 'This field is required';
    // }

    return null;
  }

  void onRatingUpdate (double rating){
    BlocProvider.of<CurrentAnswerBloc>(context).add(UpdateCurrentAnswerEvent(
      answer: ValueAnswer(value: rating.toString(), id: widget.inputId), 
      questionId: widget.questionId, ));
    setState(() {
      ratingValue = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField<double>(
      validator: validateRating,
      builder: (FormFieldState<double> field) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [
             CustomRatingBar(
              icon: widget.properties.icon == "star" ? true : false,
              initialRating: ratingValue ?? widget.properties.minimumRating,
              itemCount: (widget.properties.maximumRating - widget.properties.minimumRating).round(),
              itemSize: 25.h,
              onRatingUpdate: onRatingUpdate
             ),
              // if(ratingValue != null) Text('Selected: ${ratingValue?.toInt()}'),
              if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      field.errorText ?? '',
                      style: TextStyle(color: context.watch<ThemeBloc>().state.appColorTheme.redA700),
                    ),
                  ),
            ],
          ),
        );
      }
    );
  }
}

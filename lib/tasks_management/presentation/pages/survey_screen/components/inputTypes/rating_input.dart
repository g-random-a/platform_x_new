import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_rating_bar.dart';

class RatingInputField extends StatefulWidget {

  final RatingInputValidationSchema validations;
  final RatingPropertySchema properties;

  const RatingInputField({
    super.key,
    required this.validations,
    required this.properties,
  });

  @override
  _RatingInputFieldState createState() => _RatingInputFieldState();
}

class _RatingInputFieldState extends State<RatingInputField> {
  double? ratingValue;

  @override
  void initState() {
    super.initState();
    if (widget.properties.defaultRating != null) ratingValue = widget.properties.defaultValue?.toDouble();
  }

  String? validateRating(double? value) {
    if (widget.validations.required && value == null) {
      return widget.validations.customErrorMessage ?? 'This field is required';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<double>(
      validator: validateRating,
      builder: (FormFieldState<double> field) {
        return Column(
          children: [
           CustomRatingBar(
            icon: widget.properties.icon == "star" ? true : false
           ),
            if(ratingValue != null) Text('Selected: ${ratingValue?.toInt()}'),
            if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    field.errorText ?? '',
                    style: TextStyle(color: context.watch<ThemeBloc>().state.appColorTheme.redA700),
                  ),
                ),
          ],
        );
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';

class TextInputField extends StatefulWidget {

  final TextPropertySchema properties;
  final TextInputValidationSchema validations;

  const TextInputField({
    super.key,
    required this.properties,
    required this.validations
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.properties.defaultValue != null || widget.properties.placeholder != null) _controller.text = widget.properties.defaultValue ?? widget.properties.placeholder!;
  }

  String? validateText(String? value) {
    if (widget.validations.required && (_controller.text.isEmpty)) {
      return widget.validations.customErrorMessage ?? 'This field is required';
    }
    if (widget.validations.maxLength != null && _controller.text.length > widget.validations.maxLength!) {
      return 'Max length is ${widget.validations.maxLength} characters';
    }
    if (widget.validations.minLength != null && _controller.text.length < widget.validations.minLength!) {
      return 'Min length is ${widget.validations.minLength} characters';
    }
    if (widget.validations.regexPattern != null) {
      final regExp = RegExp(widget.validations.regexPattern!);
      if (!regExp.hasMatch(_controller.text)) {
        return 'Invalid format';
      }
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if(widget.properties.label != null && widget.properties.label!.isNotEmpty) Text(
            widget.properties.label!,
            style: CustomTextStyles.bodySmallPlusJakartaSansBlack90001(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(
              color: context.watch<ThemeBloc>().state.appColorTheme.black90002
            ),
            ),
          if(widget.properties.label != null && widget.properties.label!.isNotEmpty) SizedBox(height: 4.h,),
          TextFormField(
            controller: _controller,
            onChanged: (value) {
              Form.of(context).validate();
            },
            maxLines: widget.properties.multiLine != null ? widget.properties.lines! : 1,
            decoration: InputDecoration(
              // hintText: properties.placeholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
                borderSide: BorderSide(color: context.watch<ThemeBloc>().state.appColorTheme.black90002,)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
                borderSide: BorderSide(color: context.watch<ThemeBloc>().state.appColorTheme.green700,)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
                borderSide: BorderSide(color: context.watch<ThemeBloc>().state.appColorTheme.black90002,  )
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.21.h)),
                borderSide: BorderSide(color: context.watch<ThemeBloc>().state.appColorTheme.gray600,)
              ),
              // contentPadding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 5.h),
              // suffixText: suffix,
              // suffixStyle: TextStyle(color: context.watch<ThemeBloc>().state.appColorTheme.black90002),
              suffixIcon:  widget.properties.multiLine != null && widget.properties.suffix == null ? null :  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.properties.suffix ?? '',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
             
            ),
            // initialValue: properties.defaultValue,
            validator: validateText,
          ),
        ],
      ),
    );
  }
}

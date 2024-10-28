import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/text_input_decoration.dart';

class NumberInputField extends StatefulWidget {

  final NumberInputValidationSchema validations;
  final NumberPropertySchema properties;

  const NumberInputField({
    super.key,
    required this.properties,
    required this.validations
  });

  @override
  State<NumberInputField> createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {

  final TextEditingController _controller = TextEditingController();

  String? validateNumber(String? value) {
    if (widget.validations.required && (value == null || value.isEmpty)) {
      return widget.validations.customErrorMessage ?? 'This field is required';
    }

    if(widget.validations.allowDecimal == null || widget.validations.allowDecimal == false) {
      final int? intVal = int.tryParse(value ?? "");
      if (intVal == null){
        return 'Please enter a valid integer number';
      }
    }
    final double? numValue = double.tryParse(value ?? "" );
    
    if (numValue != null) {
      if (widget.validations.min != null && numValue < widget.validations.min!) {
        return 'Minimum value is ${widget.validations}.min';
      }
      if (widget.validations.max != null && numValue > widget.validations.max!) {
        return 'Maximum value is ${widget.validations}.max';
      }
    } else if (value != null && value.isNotEmpty) {
      return 'Please enter a valid number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // return TextFormField(
    //   decoration: InputDecoration(
    //     hintText: placeholder,
    //   ),
    //   initialValue: defaultValue?.toString(),
    //   keyboardType: TextInputType.number,
    //   validator: validateNumber,
    // );
    if (widget.properties.defaultValue != null && widget.properties.defaultValue!.toString().isNotEmpty) {
      _controller.text = widget.properties.defaultValue!.toString();
    }
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
            decoration: textInputDecoration(context, widget.properties.suffix ?? ""),
            validator: validateNumber,
            keyboardType: TextInputType.numberWithOptions(decimal: widget.validations.allowDecimal),
          ),
        ],
      ),
    );
  }
}

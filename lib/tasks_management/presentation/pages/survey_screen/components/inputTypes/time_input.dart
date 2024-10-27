import 'package:flutter/material.dart';
import 'package:platform_x/core/utils/responsive/size.dart';

class TimeInputField extends StatefulWidget {
  final String? placeholder;
  final String? defaultValue;
  final bool isRequired;
  final String? customErrorMessage;

  const TimeInputField({
    Key? key,
    this.placeholder,
    this.defaultValue,
    required this.isRequired,
    this.customErrorMessage,
  }) : super(key: key);

  @override
  State<TimeInputField> createState() => _TimeInputFieldState();
}

class _TimeInputFieldState extends State<TimeInputField> {

  String time = "";
  TextEditingController _controller = TextEditingController();

  String? validateTime(String? value) {
    if (widget.isRequired && (value == null || value.isEmpty)) {
      return widget.customErrorMessage ?? 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.placeholder,
        ),
        initialValue: widget.defaultValue,
        validator: validateTime,
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
      
          if (pickedTime != null) {
            setState(() {
            _controller.text = pickedTime.format(context);
          });
          }
          // Update field with selected time
        },
      ),
    );
  }
}

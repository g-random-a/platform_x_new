import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/application/question/bloc/current_answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/event/current_answer_event.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';

class MediaFileInputField extends StatefulWidget {
  final MediaInputValidationSchema validation;
  final MediaPropertySchema properties;
  final int inputId;
  final String questionId;

  const MediaFileInputField({
    super.key,
    required this.validation,
    required this.properties,
    required this.inputId,
    required this.questionId
  });

  @override
  _MediaFileInputFieldState createState() => _MediaFileInputFieldState();
}

class _MediaFileInputFieldState extends State<MediaFileInputField> {
  List<XFile>? selectedFiles;

  String? validateMedia(String? mediaFiles) {
    if (widget.validation.required && (selectedFiles == null || selectedFiles!.isEmpty)) {
      return 'Media file is required';
    }
    else if (widget.validation.maxFileSize != null && (selectedFiles != null && selectedFiles!.isNotEmpty)) {
      for (var file in selectedFiles!) {
        file.length().then((size) {
          if (size > widget.validation.maxFileSize!) {
            return 'File size exceeds maximum limit of ${widget.validation.maxFileSize} bytes';
          }
        });
        file.length().then(
          (size) {
            if (size > widget.validation.maxFileSize!) {
              return 'File size exceeds maximum limit of ${widget.validation.maxFileSize} bytes';
            }
          }
        );
      }
    }
    else if (widget.validation.acceptedFormats != null  && (selectedFiles != null && selectedFiles!.isNotEmpty)) {
      for (var file in selectedFiles!) {
        if (!widget.validation.acceptedFormats!.contains(file.path.split('.').last)) {
          return 'Unsupported file format, only ${widget.validation.acceptedFormats} are allowed';
        }
      }
    }
    return null;
  }

  void _initFromLocal(){
    final FileAnswer? answer = BlocProvider.of<CurrentAnswerBloc>(context).state.answers[widget.questionId + "_" + widget.inputId.toString()] as FileAnswer?;

    if (answer != null) {
      setState(() {
        selectedFiles = answer.file.map((path) => XFile(path)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initFromLocal();
  }

  Future<void> pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: widget.properties.multiple ?? false);
      if (result != null && result.paths.isNotEmpty) {
        setState(() {
          selectedFiles = result.paths.map((path) => XFile(path!)).toList();
        });
      BlocProvider.of<CurrentAnswerBloc>(context).add(UpdateCurrentAnswerEvent(answer: FileAnswer(id: widget.inputId, file: result.paths), questionId: widget.questionId));
      }

    } catch (e) {
      print('Error picking files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validateMedia,
      builder: (field) {
        return Column(
          children: [
            if (selectedFiles != null && selectedFiles!.isNotEmpty)
              ...selectedFiles!.map((file) => 
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: context.watch<ThemeBloc>().state.appColorTheme.gray10001),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(child: Text(file.path.split("/").last, style: const TextStyle(fontSize: 20,), textAlign: TextAlign.center,)),
              )
              ),
            ElevatedButton(
              onPressed: pickFiles,
              child: const Text('Pick Files'),
            ),

            if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    field.errorText ?? '',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
          ],
        );
      }
    );
  }
}

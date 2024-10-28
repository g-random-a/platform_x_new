import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_x/lib.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/infrustructure/data_provider/question/question_data_provider.dart';

class MediaFileInputField extends StatefulWidget {
  final MediaInputValidationSchema validation;
  final MediaPropertySchema properties;

  const MediaFileInputField({
    super.key,
    required this.validation,
    required this.properties,
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
        // if (size > widget.validation.maxFileSize!) {
        //   return 'File size exceeds maximum limit of ${widget.validation.maxFileSize} bytes';
        // }
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

  Future<void> pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: widget.properties.multiple ?? false);
      if (result != null && result.paths.isNotEmpty) {
        setState(() {
          selectedFiles = result.paths.map((path) => XFile(path!)).toList();
        });
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
                child: Center(child: Text(file.path.split("/").last, style: TextStyle(fontSize: 20,), textAlign: TextAlign.center,)),
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

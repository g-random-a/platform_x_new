import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';

class MediaInputField extends StatefulWidget {

  final MediaInputValidationSchema validation;
  final MediaPropertySchema properties;

  const MediaInputField({
    super.key,
    // this.acceptedFormats,
    // this.maxFileSize,
    // required this.isRequired,
    // required this.multiple,
    // this.customErrorMessage,
    required this.validation,
    required this.properties,
  });

  @override
  _MediaInputFieldState createState() => _MediaInputFieldState();
}

class _MediaInputFieldState extends State<MediaInputField> {
  List<XFile>? selectedMedia;
  final ImagePicker _picker = ImagePicker();

  Future<String?> validateMedia(List<XFile>? mediaFiles) async {
    if (widget.validation.required && (selectedMedia == null || selectedMedia!.isEmpty)) {
      return widget.validation.customErrorMessage ?? 'Media file is required';
    }
    if (widget.validation.maxFileSize != null) {
      for (var file in selectedMedia!) {
        var size = await file.length();
        if (size > widget.validation.maxFileSize!) {
          return 'File size exceeds maximum limit of ${widget.validation.maxFileSize} bytes';
        }
      }
    }
    if (widget.validation.acceptedFormats != null) {
      for (var file in mediaFiles!) {
        if (!widget.validation.acceptedFormats!.contains(file.path.split('.').last)) {
          return 'Unsupported file format';
        }
      }
    }

    return null;
  }

  Future<void> pickMedia() async {
    try {
      if (widget.validation.multiple != null && widget.validation.multiple!) {
        final mediaFiles = await _picker.pickMultiImage();
        setState(() {
          selectedMedia = mediaFiles;
        });
      } else {
        final mediaFile = await _picker.pickImage(source: ImageSource.gallery);
        if (mediaFile != null) {
          setState(() {
            selectedMedia = [mediaFile];
          });
        }
      }
    } catch (e) {
      print('Error picking media: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selectedMedia != null && selectedMedia!.isNotEmpty)
          ...selectedMedia!.map((file) => Text(file.path)),
        ElevatedButton(
          onPressed: pickMedia,
          child: const Text('Pick Media'),
        ),
      ],
    );
  }
}

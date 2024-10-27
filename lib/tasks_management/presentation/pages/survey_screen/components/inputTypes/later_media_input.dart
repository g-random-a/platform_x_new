import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaInputField extends StatefulWidget {
  final List<String>? acceptedFormats;
  final int? maxFileSize;
  final bool isRequired;
  final bool multiple;
  final String? customErrorMessage;

  const MediaInputField({
    Key? key,
    this.acceptedFormats,
    this.maxFileSize,
    required this.isRequired,
    required this.multiple,
    this.customErrorMessage,
  }) : super(key: key);

  @override
  _MediaInputFieldState createState() => _MediaInputFieldState();
}

class _MediaInputFieldState extends State<MediaInputField> {
  List<XFile>? selectedMedia;
  final ImagePicker _picker = ImagePicker();

  Future<String?> validateMedia(List<XFile>? mediaFiles) async {
    if (widget.isRequired && (mediaFiles == null || mediaFiles.isEmpty)) {
      return widget.customErrorMessage ?? 'Media file is required';
    }
    if (widget.maxFileSize != null) {
      for (var file in mediaFiles!) {
        var size = await file.length();
        if (size > widget.maxFileSize!) {
          return 'File size exceeds maximum limit of ${widget.maxFileSize} bytes';
        }
      }
    }
    if (widget.acceptedFormats != null) {
      for (var file in mediaFiles!) {
        if (!widget.acceptedFormats!.contains(file.path.split('.').last)) {
          return 'Unsupported file format';
        }
      }
    }
    return null;
  }

  Future<void> pickMedia() async {
    try {
      if (widget.multiple) {
        final mediaFiles = await _picker.pickMultiImage();
        if (mediaFiles != null) {
          setState(() {
            selectedMedia = mediaFiles;
          });
        }
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
        ElevatedButton(
          onPressed: pickMedia,
          child: Text('Pick Media'),
        ),
        if (selectedMedia != null && selectedMedia!.isNotEmpty)
          ...selectedMedia!.map((file) => Text(file.path)).toList(),
      ],
    );
  }
}

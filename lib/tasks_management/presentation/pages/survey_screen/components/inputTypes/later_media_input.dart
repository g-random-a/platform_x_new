import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_image.dart';

import '../../../../../../core/application/theme/bloc/theme_bloc.dart';

class MediaInputField extends StatefulWidget {
  final MediaInputValidationSchema validation;
  final MediaPropertySchema properties;

  const MediaInputField({
    super.key,
    required this.validation,
    required this.properties,
  });

  @override
  _MediaInputFieldState createState() => _MediaInputFieldState();
}

class _MediaInputFieldState extends State<MediaInputField> {
  List<XFile>? selectedMedia = [];
  final ImagePicker _picker = ImagePicker();

  String? validateMedia(String? mediaFiles)  {
    print("validating data");
    if (widget.validation.required && (selectedMedia == null || selectedMedia!.isEmpty)) {
      return widget.validation.customErrorMessage ?? 'Media file is required';
    }
    // if (widget.validation.maxFileSize != null) {
    //   for (var file in selectedMedia!) {
    //     var size = file.
    //         if (value > widget.validation.maxFileSize!) {
    //           return 'File size exceeds maximum limit of ${widget.validation.maxFileSize} bytes';
    //         }
    //   };
        
    // }
    if (widget.validation.acceptedFormats != null) {
      for (var file in selectedMedia!) {
        if (!widget.validation.acceptedFormats!.contains(file.path.split('.').last)) {
          return 'Unsupported file format';
        }
      }
    }
    return null;
  }

  Future<void> pickMedia(BuildContext ctx) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Media"),
          content: const Text("Choose an option to select media"),
          actions: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final mediaFile = await _picker.pickImage(source: ImageSource.camera);
                    if (mediaFile != null) {
                      setState(() {
                        selectedMedia = [mediaFile];
                      });
                    }
                  },
                  icon: const Icon(Iconsax.camera, color: Colors.purple),
                  label: Text('Take photo',
                            style:
                        CustomTextStyles.labelLargePlusJakartaSans13(
                                  context.watch<ThemeBloc>().state.themeData,
                                  context.watch<ThemeBloc>().state.appColorTheme).copyWith(color: context.watch<ThemeBloc>().state.appColorTheme.black90001),
                            ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    textStyle: const TextStyle(color: Colors.black),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    elevation: 2,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.of(context).pop();
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
                  },
                  icon: const Icon(Iconsax.document, color: Colors.purple),
                  label: Text('Pick from Gallery',
                            style:
                        CustomTextStyles.labelLargePlusJakartaSans13(
                                  context.watch<ThemeBloc>().state.themeData,
                                  context.watch<ThemeBloc>().state.appColorTheme).copyWith(color: context.watch<ThemeBloc>().state.appColorTheme.black90001),
                            ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    textStyle: const TextStyle(color: Colors.black),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    elevation: 2,
                  ),
                ),
              ),
            ),
            // TextButton(
            //   onPressed: ,
            //   child: const Text("Pick from Gallery"),
            // ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validateMedia,
      builder: (field) {
        return Stack(
          children: [
            
            if(selectedMedia != null)
            ...(selectedMedia!.map((image)
              {
                return CustomImageView(
                  imagePath: image.path,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: 250.h,
                  captured: true,
              );
              
              },)),
        
            if(selectedMedia != null)
            ...(selectedMedia!.map((image)
              {
                return Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Iconsax.close_circle, color: context.watch<ThemeBloc>().state.appColorTheme.redA700),
                    onPressed: (){
                      setState(() {
                      });
                    },
                  ),
                );
              }
            ,)),
            
            Container(
              // width: MediaQuery.of(context).size.width,
              height: selectedMedia == null || selectedMedia!.isEmpty ? 45.vh : 250.vh,
              child: Align(
                alignment: selectedMedia == null || selectedMedia!.isEmpty ? Alignment.center : Alignment.bottomCenter,
                child: Container(
                  child: Padding(
                    padding: selectedMedia == null || selectedMedia!.isEmpty ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: 8.h),
                    child: CustomElevatedButton(
                      onclick: (){
                        pickMedia(context);
                      },
                      text: 'Pick Media',
                      ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}

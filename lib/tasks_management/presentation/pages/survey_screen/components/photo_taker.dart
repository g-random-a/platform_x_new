import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'dart:io';

import 'package:platform_x/tasks_management/presentation/components/custom_image.dart';

class TakePhotoComponent extends StatefulWidget {

  final MediaInputValidationSchema validations;
  final MediaPropertySchema properties;

  const TakePhotoComponent({super.key, required this.validations, required this.properties});
  
  @override
  _TakePhotoComponentState createState() => _TakePhotoComponentState();
}

class _TakePhotoComponentState extends State<TakePhotoComponent> {
  File? _image;

  // Function to take a photo
  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  String? validatPhoto(double? value) {
    if (_image == null) {
      return 'This field is required';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<double>(
      validator: validatPhoto,
      builder: (FormFieldState<double> field) {
        return Column(
          children: [
            if (widget.properties.label != null &&
              widget.properties.label!.isNotEmpty)
            Text(
              widget.properties.label!,
              style: CustomTextStyles.bodySmallPlusJakartaSansBlack90001(
                  context.watch<ThemeBloc>().state.themeData,
                  context.watch<ThemeBloc>().state.appColorTheme),
            ),
            Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  height: _image == null ? 45.h : 290.h,
                  child: Stack(
                    children: [
                      if(_image != null ) CustomImageView(
                        imagePath: _image?.path,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: 290.h,
                        captured: true,
                      ),
                      if(_image != null ) Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Iconsax.close_circle, color: context.watch<ThemeBloc>().state.appColorTheme.redA700),
                          onPressed: (){
                            setState(() {
                              _image = null;
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: _image == null ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: 8.h),
                          child: ElevatedButton.icon(
                            onPressed: _takePhoto,
                            icon: const Icon(Iconsax.camera, color: Colors.purple),
                            label: _image  != null ? 
                            Text('Retake photo', 
                                style:
                                  CustomTextStyles.labelLargePlusJakartaSans13(
                                            context.watch<ThemeBloc>().state.themeData,
                                            context.watch<ThemeBloc>().state.appColorTheme).copyWith(color: context.watch<ThemeBloc>().state.appColorTheme.black90001),
                                      ) : Text('Take photo',
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
                    ],
                  ),
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

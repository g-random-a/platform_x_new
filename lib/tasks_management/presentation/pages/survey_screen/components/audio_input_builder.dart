import 'package:flutter/material.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_voice_message.dart';
import 'package:platform_x/tasks_management/presentation/pages/survey_screen/components/inputTypes/audio_recoder_picker.dart';

class AudioInputBuilder extends StatefulWidget {
 
  final MediaInputValidationSchema validation;
  final MediaPropertySchema property;

  const AudioInputBuilder({
    super.key,
    required this.validation,
    required this.property
  });

  @override
  State<AudioInputBuilder> createState() => _AudioInputBuilderState();
}

class _AudioInputBuilderState extends State<AudioInputBuilder> {

  String? audioFilePath;

  void updateAudioFilePath (String newFilePath) {
    setState(() {
      audioFilePath = newFilePath;
    });
  }

  void cancelRecordedAudio(){
    setState(() {
      audioFilePath = null;
    });
  }

  String? validateAudio(String? value){
    if (widget.validation.required && audioFilePath == null){
      return "This field is required";
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
  print(widget.property.label);
    return FormField<String>(
      builder: (field) {
        return Container(
          // decoration: BoxDecoration(
          //         border: Border.all(
          //           color: Colors.grey,
          //           width: 1.0,
          //         ),
          //         borderRadius: BorderRadius.circular(15.0),
          //       ),
          // margin: EdgeInsets.only(bottom: 10.h),
          // padding: EdgeInsets.all(4.h),
          child: Column(
            children: [
              if (widget.property.label != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.property.label!,
                    ),
                  ),
              audioFilePath == null ? AudioRecorderWidget(onRecorded: updateAudioFilePath) : VoiceMessageWidget(audioUrl: audioFilePath!, isFile: true, onPause: (){}, onPlaying: (){}, isRecorded: true, onClose: cancelRecordedAudio),
              if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      field.errorText ?? '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
            ],
          ),
        );
      },
      validator: validateAudio,
      );
  }
}
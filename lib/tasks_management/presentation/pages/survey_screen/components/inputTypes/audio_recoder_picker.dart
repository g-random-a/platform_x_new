import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:platform_x/core/utils/theme/text_theme.dart';
import 'package:record/record.dart';

class AudioRecorderWidget extends StatefulWidget {
  final Function onRecorded;
  const AudioRecorderWidget({
    super.key,
    required this.onRecorded
    
    });

  @override
  _AudioRecorderWidgetState createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  String _audioPath = 'audio.mp3';
  Duration _position = Duration.zero;
  bool isRecording = false;
  Timer? _positionUpdateTimer;
  final AudioRecorder _audioRecorder = AudioRecorder();
  

  @override
  void initState() {
    super.initState();
    _audioRecorder.dispose();
  }

  @override
  void dispose() {
    if(_positionUpdateTimer != null && _positionUpdateTimer!.isActive) _positionUpdateTimer?.cancel();
    super.dispose();
  }

  void _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          _audioPath = filePath;
          widget.onRecorded(filePath);
        });
      }
    }
  }

  Future<void> toggleRecording() async {
    if (isRecording) {
      final path = await _audioRecorder.stop();
      setState(() {
        isRecording = false;
        _positionUpdateTimer?.cancel();
      });
      widget.onRecorded(path);
      print("Recording saved at: $path");
    } else {
      try {
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = '${tempDir.path}/recorded_audio.aac';
        await _audioRecorder.start(const RecordConfig(
        ), path: tempPath);
        setState(() {
          isRecording = true;
        });
        _positionUpdateTimer = Timer.periodic(const Duration(seconds: 1), (_) {
            setState(() {
              _position += const Duration(seconds: 1);
            });
          });

      } catch (e) {
        print("Error starting recording: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(!isRecording) IconButton(
            icon: Icon(
              Icons.add,
              color: context.watch<ThemeBloc>().state.appColorTheme.gray600,
              size: 24,
            ),
            onPressed: _pickAudioFile,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: isRecording ? context.watch<ThemeBloc>().state.appColorTheme.green700 : context.watch<ThemeBloc>().state.appColorTheme.green100,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: isRecording ? MainAxisAlignment.center : MainAxisAlignment.end,
                children: [
                  Text(
                    '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isRecording ? context.watch<ThemeBloc>().state.appColorTheme.whiteA70001 : context.watch<ThemeBloc>().state.appColorTheme.green700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onLongPress: toggleRecording,
            onLongPressEnd: (details) => toggleRecording(),
            child: Icon(
              isRecording ? Iconsax.stop : Iconsax.microphone_2,
              color: context.watch<ThemeBloc>().state.appColorTheme.gray600,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}


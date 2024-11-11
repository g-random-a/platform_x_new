import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:platform_x/core/application/locale/bloc/locale_bloc.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/responsive/size.dart';
import 'package:voice_message_package/voice_message_package.dart';
import 'package:just_audio/just_audio.dart';

class VoiceMessageWidget extends StatefulWidget {
  final String audioUrl;
  final bool isFile;
  final Function() onPause;
  final Function() onPlaying;
  final bool isRecorded;
  final Function()? onClose;

  const VoiceMessageWidget({
    super.key,
    required this.audioUrl,
    required this.isFile,
    required this.onPause,
    required this.onPlaying,
    required this.isRecorded,
    this.onClose
  });

  @override
  _VoiceMessageWidgetState createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  VoiceController? voiceController;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
     _audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        setState(() {
          isPlaying = true;
        });
        widget.onPlaying();
      } else {
        setState(() {
          isPlaying = false;
        });
        widget.onPause();
      }
    });
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    try {
      await _audioPlayer.setFilePath(widget.audioUrl);
      await _audioPlayer.load();
      voiceController = VoiceController(
                  audioSrc: widget.audioUrl,
                  onComplete: () {
                    // handle audio completion
                  }, 
                  maxDuration: _audioPlayer.duration ?? Duration.zero,
                  isFile: widget.isFile,
                  cacheKey: Random.secure().nextInt(10000).toString(), 
                  onPause: widget.onPause, 
                  onPlaying: widget.onPlaying,
                );
    } catch (e) {
      print('Error loading audio: $e');
    }
  }


  @override
  void dispose() {
    _audioPlayer.dispose();
    if (voiceController != null) voiceController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0.h),
      width: MediaQuery.of(context).size.width,
      margin:  EdgeInsets.only(top: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: widget.isRecorded ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (widget.isRecorded) 
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
          //     Text(
          //   'Audio Answer Answer',
          //   style: TextStyle(
          //     fontSize: 10.fSize,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
            ],
          ),

          Row(
            mainAxisAlignment: widget.isRecorded ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              voiceController == null ? 
              Center(
                child: CircularProgressIndicator(
                  color: context.watch<ThemeBloc>().state.appColorTheme.blue700,
                ),
              ) :
              VoiceMessageView(
                playPauseButtonLoadingColor: context.watch<ThemeBloc>().state.appColorTheme.blue700,
                activeSliderColor: context.watch<ThemeBloc>().state.appColorTheme.green200,
                circlesColor: context.watch<ThemeBloc>().state.appColorTheme.green700,
                // backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.redA700,
                controller: voiceController!,
                innerPadding: 12,
                cornerRadius: 20,
              ),
              if (voiceController == null) const Spacer(),
              if (widget.isRecorded) 
                IconButton(onPressed: widget.onClose, icon: const Icon(Iconsax.close_circle)),
            ],
          ),
        ],
      ),
    );
  }
}

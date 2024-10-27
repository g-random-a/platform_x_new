// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iconsax/iconsax.dart';
// import 'dart:async';
// import 'package:path_provider/path_provider.dart';

// import 'package:platform_x/core/utils/responsive/size.dart';
// import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
// import 'package:just_audio/just_audio.dart';

// class AudioPlayerWidget extends StatefulWidget {
//   const AudioPlayerWidget({super.key});

//   @override
//   _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
// }

// class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
//   bool _isPlaying = false;
//   String _audioPath = 'audio.mp3';
//   Duration _position = Duration.zero;
//   bool _isRecording = false;
//   final RecorderController _recorderController = ;
//   bool _isAudioFileReady = false;
//   Timer? _positionUpdateTimer;
//   bool _isPlayingDone = false;

//   @override
//   void initState() {
//     super.initState();
//     _setupPositionListener();
//   }

//   @override
//   void dispose() {
//     _playerController.dispose();
//     _recorderController.dispose();
//     _positionUpdateTimer?.cancel();
//     super.dispose();
//   }

//   void _setupPositionListener() {
//     _playerController.onCurrentDurationChanged.listen(
//       (event) async {
//         if (_playerController.playerState == PlayerState.playing) {
//           int? currentPosition = await _playerController.getDuration(DurationType.current);
//           if (currentPosition != null) {
//             setState(() {
//               _position = Duration(milliseconds: currentPosition);
//             });
//           }
//         }
//       },
//     );

//     Stream<Duration> currentDuration = _recorderController.onCurrentDuration;
//     currentDuration.listen((event) {
//       if (_isRecording) {
//         setState(() {
//           _position = event;
//         });
//       }
//     });

//     _recorderController.onRecorderStateChanged.listen((event) {
//       if (event.isPaused) {
//         setState(() {
//           _isRecording = false;
//         });
//       }
//     });

//     _playerController.onPlayerStateChanged.listen((event) async {
//       if (event == PlayerState.stopped) {
//         setState(() {
//           _isPlaying = false;
//           _isPlayingDone = true;
//         });
//       }

//       if (event == PlayerState.paused) {
//         setState(() {
//           _isPlaying = false;
//         });
//       }
//     });

//     _recorderController.onRecordingEnded.listen((event) {
//       setState(() {
//         _isRecording = false;
//         _isAudioFileReady = true;
//         _playerController.preparePlayer(path: _audioPath, shouldExtractWaveform: true);
//       });
//     });

//     _playerController.onCompletion.listen((event) async {
//       await _playerController.stopPlayer();
//       setState(() {
//         _isPlaying = false;
//         _isPlayingDone = true;
//       });
//     });
//   }

//   Future<void> _resetPlayer() async {
//       await _playerController.preparePlayer(path: _audioPath, shouldExtractWaveform: true);
//       setState(() {
//         _isPlayingDone = false;
//       });
//   }

//   void _playPauseAudio() async {
//     if (_isPlayingDone) {
//       await _resetPlayer();
//       await _playerController.startPlayer(finishMode: FinishMode.loop, forceRefresh: true);
//       setState(() {
//         _isPlaying = true;
//       });
//     } else if (_isPlaying) {
//       await _playerController.pausePlayer();
//     } else {
//       _recorderController.refresh();
//       await _playerController.startPlayer(finishMode: FinishMode.loop, forceRefresh: true);
//       setState(() => _isPlaying = true);
//     }
//   }

//   void _pickAudioFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
//     if (result != null) {
//       String? filePath = result.files.single.path;
//       if (filePath != null) {
//         setState(() {
//           _audioPath = filePath;
//           _isAudioFileReady = true;
//         });
//         await _resetPlayer();
//       }
//     }
//   }

//   void _recordAudio() async {
//     if (_isRecording) {
//       await _recorderController.stop();
//       await _resetPlayer();
//       setState(() {
//         _isRecording = false;
//         _isAudioFileReady = true;
//       });
//     } else {
//       Directory tempDir = await getTemporaryDirectory();
//       String tempPath = '${tempDir.path}/recorded_audio.aac';
//       _recorderController.record(path: tempPath);
//       setState(() {
//         _audioPath = tempPath;
//         _isRecording = true;
//         _isAudioFileReady = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: Icon(
//               Icons.add,
//               color: context.watch<ThemeBloc>().state.appColorTheme.gray600,
//               size: 24,
//             ),
//             onPressed: _pickAudioFile,
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               decoration: BoxDecoration(
//                 color: context.watch<ThemeBloc>().state.appColorTheme.green100,
//                 borderRadius: BorderRadius.circular(5.0),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: context.watch<ThemeBloc>().state.appColorTheme.green700,
//                     ),
//                   ),
//                   Expanded(
//                     child: _isRecording
//                         ? Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8.0.h),
//                             child: AudioWaveforms(
//                               recorderController: _recorderController,
//                               size: const Size(double.infinity, 30.0),
//                               waveStyle: WaveStyle(
//                                 waveColor: context.watch<ThemeBloc>().state.appColorTheme.green700,
//                                 extendWaveform: true,
//                               ),
//                             ),
//                           )
//                         : AudioFileWaveforms(
//                             playerWaveStyle: PlayerWaveStyle(
//                               liveWaveColor: context.watch<ThemeBloc>().state.appColorTheme.green700,
//                               seekLineColor: context.watch<ThemeBloc>().state.appColorTheme.green700,
//                               waveCap: StrokeCap.round,
//                             ),
//                             continuousWaveform: true,
//                             size: const Size(double.infinity, 30.0),
//                             playerController: _playerController,
//                             enableSeekGesture: true,
//                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                             backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.green700,
//                           ),
                          
//                   ),
//                   if (_isAudioFileReady)
//                     IconButton(
//                       icon: Icon(
//                         _isPlaying ? Icons.pause : _isPlayingDone ? Icons.refresh : Icons.play_arrow,
//                         color: context.watch<ThemeBloc>().state.appColorTheme.gray600,
//                         size: 24,
//                       ),
//                       onPressed: _playPauseAudio,
//                     ),
//                 ],
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(
//               _isRecording ? Iconsax.stop : Iconsax.microphone_2,
//               color: context.watch<ThemeBloc>().state.appColorTheme.gray600,
//               size: 24,
//             ),
//             onPressed: _recordAudio,
//           ),
//         ],
//       ),
//     );
//   }
// }


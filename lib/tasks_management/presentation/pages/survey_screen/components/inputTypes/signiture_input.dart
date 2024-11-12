import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/tasks_management/application/question/bloc/current_answer_bloc.dart';
import 'package:platform_x/tasks_management/application/question/event/current_answer_event.dart';
import 'package:platform_x/tasks_management/domain/answerType.dart';
import 'package:platform_x/tasks_management/domain/inputPropertiesType.dart';
import 'package:platform_x/tasks_management/domain/inputValidation.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_elevated_button.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SketchFormField extends FormField<Uint8List> {

  final SignatureInputValidationSchema validations;
  final SignaturePropertySchema properties;
  final String questionId;
  final int inputId;

  SketchFormField({
    super.key,
    required this.properties,
    required this.validations,
    required this.questionId,
    required this.inputId,
  }) : super(
          validator: (Uint8List? value) {
            if (validations.required && value == null) {
              return 'This field is required';
            }
            return null;
          },
          
          builder: (FormFieldState<Uint8List> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SketchCanvas(
                  onExported: (Uint8List imageBytes) {
                    state.didChange(imageBytes);
                  },
                  questionId: questionId,
                  inputId: inputId,
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        );
}

class SketchCanvas extends StatefulWidget {
  final ValueChanged<Uint8List> onExported;
  final String questionId;
  final int inputId;

  const SketchCanvas({Key? key, required this.onExported, required this.inputId, required this.questionId }) : super(key: key);

  @override
  _SketchCanvasState createState() => _SketchCanvasState();
}

class _SketchCanvasState extends State<SketchCanvas> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
  );
  final GlobalKey _canvasKey = GlobalKey();

  Image? signed;
  

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _exportCanvas() async {
    try {
      final boundary = _canvasKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final imageBytes = byteData.buffer.asUint8List();
        widget.onExported(imageBytes);
      }
      setState(() {
        signed = byteData != null ? Image.memory(byteData.buffer.asUint8List()) : null;
      });
    } catch (e) {
      print("Error exporting canvas: $e");
    }
  }

  Future<void> _saveAsImage() async {
    
    try {
      print("saving image");
      print("----------------------------------------------------------------");
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/sketch${widget.questionId}_${widget.inputId}.png';
      final imageBytes = await _controller.toPngBytes();
      if (imageBytes != null) {
        final file = File(filePath);
        await file.writeAsBytes(imageBytes);
        await _exportCanvas();
        _controller.clear();
        BlocProvider.of<CurrentAnswerBloc>(context).add(UpdateCurrentAnswerEvent(answer: FileAnswer(id: widget.inputId, file: [filePath]), questionId: widget.questionId));
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('there is an issue saving your sketch, please try again.')),
      );
    }
  }

  void _initFromLocal(){
    final FileAnswer? answer = BlocProvider.of<CurrentAnswerBloc>(context).state.answers[widget.questionId + "_" + widget.inputId.toString()] as FileAnswer?;

    if (answer != null) {
      setState(() {
        // i can get file path from answer.file[0] and load it as image
        signed = Image.file(File(answer.file[0])); 
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _initFromLocal();
  }

  void _clearCanvas() {
    _controller.clear();
    setState(() {
      signed = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (signed != null) Text("Your signature: "),
        if (signed != null) Image(image: signed!.image),
        if(signed != null) const SizedBox(height: 10),
        if(signed == null) RepaintBoundary(
          key: _canvasKey,
          child: Signature(
            controller: _controller,
            height: 300,
            backgroundColor: Colors.grey[200]!,

          ),
          
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(signed != null) Expanded(
                child: CustomElevatedButton(
                  onclick: _clearCanvas,
                  text: 'Clear',
                  backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.redA700,
                  textColor: context.watch<ThemeBloc>().state.appColorTheme.redA700,
                  outlined: true,
                  ),
              ),
              const SizedBox(width: 10),
              if(signed == null) Expanded(
                child: CustomElevatedButton(
                  onclick: () async{
                    await _saveAsImage(); 
                    Form.of(context).validate();

                    // FormField.of(context)!.validate();
                  },
                  text: 'Save',
                  backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.green700,
                  textColor: context.watch<ThemeBloc>().state.appColorTheme.green700,
                  outlined: true,
                  ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

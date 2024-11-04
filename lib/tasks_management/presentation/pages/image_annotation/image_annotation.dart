import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';

class AnnotatedImageFormField extends FormField<Uint8List> {
  AnnotatedImageFormField({
    Key? key,
    required ImageProvider imageProvider,
    FormFieldSetter<Uint8List>? onSaved,
    FormFieldValidator<Uint8List>? validator,
    bool autovalidateMode = false,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: null,
          autovalidateMode: autovalidateMode ? AutovalidateMode.always : AutovalidateMode.disabled,
          builder: (FormFieldState<Uint8List> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    final imagePainterController = ImagePainterController();
                    final result = await Navigator.of(state.context).push(
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(title: Text("Annotate Image")),
                          body: ImagePainter.asset(
                            "assets/task_instruction.png",
                            controller: imagePainterController, 
                          ),
                          floatingActionButton: FloatingActionButton(
                            onPressed: () async {
                              final mask = await imagePainterController.exportImage(); // Exports only the mask as Uint8List
                              state.didChange(mask);
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.check),
                          ),
                        ),
                      ),
                    );

                    if (result != null) {
                      state.didChange(result);
                    }
                  },
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: state.value == null
                        ? Center(child: Text("Tap to annotate"))
                        : Image.memory(state.value!, fit: BoxFit.cover),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      state.errorText!,
                      style: TextStyle(color: Theme.of(state.context).dividerColor, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        );
}

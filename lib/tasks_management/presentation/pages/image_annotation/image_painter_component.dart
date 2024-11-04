import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:platform_x/tasks_management/presentation/pages/image_annotation/image_annotation.dart';

class AnnotationFormScreen extends StatefulWidget {
  @override
  _AnnotationFormScreenState createState() => _AnnotationFormScreenState();
}

class _AnnotationFormScreenState extends State<AnnotationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  Uint8List? _annotatedMask;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Annotation Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AnnotatedImageFormField(
                imageProvider: AssetImage("assets/sample_image.jpg"),
                validator: (value) {
                  if (value == null) {
                    return "Annotation is required";
                  }
                  return null;
                },
                onSaved: (value) {
                  _annotatedMask = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum ButtonVariant { blue, red, green, yellow, purple }

// Light and Dark Button Colors
Map<ButtonVariant, Color> lightButtonColors = {
  ButtonVariant.blue: Colors.blue,
  ButtonVariant.red: Colors.red,
  ButtonVariant.green: Colors.green,
  ButtonVariant.yellow: Colors.yellow,
  ButtonVariant.purple: Colors.purple,
};

Map<ButtonVariant, Color> darkButtonColors = {
  ButtonVariant.blue: Colors.blueGrey,
  ButtonVariant.red: Colors.red[800]!,
  ButtonVariant.green: Colors.green[800]!,
  ButtonVariant.yellow: Colors.amber[600]!,
  ButtonVariant.purple: Colors.deepPurple[700]!,
};

ButtonStyle getButtonStyle(BuildContext context, ButtonVariant variant) {
  final brightness = Theme.of(context).brightness;
  final colors = brightness == Brightness.light ? lightButtonColors : darkButtonColors;

  return ElevatedButton.styleFrom(
    foregroundColor: colors[variant],
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    textStyle: const TextStyle(fontSize: 16),
  );
}
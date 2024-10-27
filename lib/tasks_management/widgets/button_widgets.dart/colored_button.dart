import 'package:flutter/material.dart';
import 'package:platform_x/core/utils/theme/variants/buttom_variants.dart';

class ColoredButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;

  const ColoredButton({super.key, 
    required this.text,
    required this.onPressed,
    required this.variant,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: getButtonStyle(context, variant),
      child: Text(text),
    );
  }
}

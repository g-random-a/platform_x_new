import 'package:flutter/material.dart';

Widget buildDivider(String text) {
    return Row(
      children: [
        const Expanded(
            child: Divider(
          color: Colors.lightBlue,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800, // Bold text.
              color: Colors.blue, // Blue color.
            ),
          ),
        ),
        const Expanded(
            child: Divider(
          color: Colors.lightBlue,
        )),
      ],
    );
  }

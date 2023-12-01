import 'package:flutter/material.dart';

Widget buildSubmitButton({
  required bool isButtonDisabled,
  required VoidCallback onPressed,
  required String buttonText,
}) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: isButtonDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF7946A0),
      ),
      child: Text(buttonText),
    ),
  );
}

import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String labelText,
  required String? Function(String?) validator,
  required void Function(String)? onChanged,
}) {
  return Row(
    children: [
      const Icon(
        Icons.lock_open_rounded,
        size: 25,
        color: Colors.orange,
      ),
      const SizedBox(width: 17.0),
      Expanded(
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(fontSize: 13),
          ),
          validator: validator,
        ),
      ),
    ],
  );
}

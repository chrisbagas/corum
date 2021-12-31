import 'package:flutter/material.dart';
          
Widget buildTextFormField(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      decoration:  InputDecoration(
        labelText: text,
        icon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0)
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "$text is required";
        }
      },
      onSaved: (String? value) {
        text = value ?? "";
      },
    ),
  );
}
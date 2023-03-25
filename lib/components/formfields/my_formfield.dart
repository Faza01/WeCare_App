// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final controller;
  final String? hintText;
  final String? prefixText;
  final Function()? keyboardType;

  const MyFormField({super.key, required this.controller, this.hintText, this.prefixText, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType != null ? keyboardType!() : null,
      style: TextStyle(fontSize: 15, color: Color(0xff545050)),
      decoration: InputDecoration(
        prefixText: prefixText,
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        hintText: hintText,
          hintStyle: hintText != null ? TextStyle(color: Colors.grey[500]) : null,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  final controller;

  const MyDatePicker({super.key, required this.controller});

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  // create datetime variable
  DateTime _dateTime = DateTime.now();

  // date picker
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
          widget.controller.text =
              '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onTap: _showDatePicker,
      style: TextStyle(fontSize: 15, color: Color(0xff545050)),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        hintText: 'Select Date',
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

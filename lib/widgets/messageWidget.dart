// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  // Custum message
  final String message;
  final String date;
  MessageWidget({required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/sucess.png'),
                    fit: BoxFit.cover
                )
            )
        ),
        SizedBox(width: 12),
        SizedBox(
          width: 240,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(
              (message),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              (date),
              style: TextStyle(
                  fontSize: 12),
            )
          ]),
        ),

      ],
    );
  }
}

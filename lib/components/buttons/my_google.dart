// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ButtonGoogle extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const ButtonGoogle({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 25.0,
              width: 25.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ic_google.png'),
                    fit: BoxFit.cover),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10),
            Text(
              (text),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ],
        ),),
    );
  }
}

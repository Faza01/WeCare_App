// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {

  final String title;
  AppBarWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 4.5),
        child: Text(
          (title),
          style: TextStyle(
            color: Color(0xff545050),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    )
    );
  }
}

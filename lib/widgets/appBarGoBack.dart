// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppBarGoBack extends StatelessWidget {

  final String title;
  AppBarGoBack({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        child: AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
        iconSize: 25,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      elevation: 0.0,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 4.5, left: 3),
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

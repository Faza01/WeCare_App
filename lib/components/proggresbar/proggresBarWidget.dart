// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class ProggresBarWidget extends StatelessWidget {
  final double progress;
  final Color filledColor;
  final Color emptyColor;
  final String persentage;

  ProggresBarWidget({required this.progress, required this.filledColor, required this.emptyColor, required this.persentage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                height: 5,
                width: MediaQuery.of(context).size.width * 0.73,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: emptyColor,
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: filledColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 9),
              Text((persentage), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff3B91CF)))
            ],
          ),
        ),
      ],
    );
  }
}

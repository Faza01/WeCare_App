// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wecare/widgets/appBar.dart';
import 'package:wecare/widgets/appBarGoBack.dart';
import 'package:wecare/widgets/messageWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarWidget(title: 'Message',),
        ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(29),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MessageWidget(message: 'Donasi Berhasil', date: '25 January'),
              SizedBox(height: 20),
              MessageWidget(message: 'Terimakasih Sudah Berdonasi', date: '26 January',)
            ],
          ),
        )
    )
    );
  }
}

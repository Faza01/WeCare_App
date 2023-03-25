// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:wecare/widgets/donationsWidget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${user.email!}",),
        actions: [
        IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
      ]),
      backgroundColor: Color(0xffE7E6E6),
      body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(29),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff545050)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffd9d9d9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search here",
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0),
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Color(0xff000000),
                  ),
                ),
                // Search Bar

                SizedBox(height: 20),
                // Box
                Stack(
                  children: [
                    Positioned(
                        child: Material(
                          color: Color(0xffE7E6E6),
                      child: Container(
                        height: 109,
                        decoration: BoxDecoration(
                            color: Color(0xff3B91CF),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )),
                    Positioned(
                      top: 9,
                      left: 10,
                      child: SizedBox(
                        height: 83,
                        width: 111,
                        child: (Image(
                          image: AssetImage('assets/give.png'),
                        )),
                      ),
                    ),
                    Positioned(
                        top: 15,
                        left: 143,
                        child: SizedBox(
                          width: 157,
                          child: Column(children: [
                            Text(
                              "No one has ever become poor by giving",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                        ))
                  ],
                ),
                SizedBox(height: 20),
                // Donation
                Text.rich(
                  TextSpan(
                      text: 'Donation',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  style: TextStyle(fontSize: 12),
                ),

                SizedBox(height: 20),
                // Donation
                GridDB()
              ],
            )),
    ),
      )
    );
  }
}

// final donations = ['kakek', 'pasien', 'bayi'];

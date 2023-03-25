// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wecare/pages/donation.dart';
import 'package:wecare/pages/payment.dart';
import 'package:wecare/widgets/appBarGoBack.dart';
import '../components/buttons/my_button.dart';
import '../components/proggresbar/proggresBarGrid.dart';
import '../components/proggresbar/proggresBarWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GridDB extends StatelessWidget {
  const GridDB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference<Map<String, dynamic>> donationsRef =
        FirebaseFirestore.instance.collection('donations');

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: donationsRef.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<Map<String, dynamic>?> donations = snapshot.data!.docs
              .map((DocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
              .toList();

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 12.0,
                mainAxisExtent: 240),
            itemCount: donations.length,
            itemBuilder: (_, index) {
              final donation = donations[index];

              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Image.network(
                            donation![
                                'downloadUrl'], // use the downloadUrl field to get the image URL
                            height: 170,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const Icon(Icons.error);
                            },
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5.0),
                          child: Column(
                            children: [
                              Text("${donation['title']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 12))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          // Costum Proggres Bar
                          child: ProggresBarGrid(
                              progress: 0.7,
                              filledColor: Color(0xff3B91CF),
                              emptyColor: Color(0xffD9D9D9),
                              persentage: '70%'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Target : Rp.${donation['goal']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Text("until ${donation['duration']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 12))
                            ],
                          ),
                        ),
                      ]),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => DetailDonations(
                          images: donation['downloadUrl'],
                          title: donation['title'],
                          organized: donation['organized'],
                          duration: donation['duration'],
                          description: donation['description'],
                          goal: donation['goal'],
                        ))),
              );
            },
          );
        });
  }
}

class DetailDonations extends StatelessWidget {
  DetailDonations(
      {required this.title,
      required this.organized,
      required this.images,
      required this.description,
      required this.goal,
      required this.duration,});
  final String title;
  final String organized;
  final String images;
  final String description;
  final String goal;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarGoBack(
          title: 'Detail Donations',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(29),
        child: ListView(
          children: [
            Material(
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                            images, // use the downloadUrl field to get the image URL
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const Icon(Icons.error);
                            },
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                    ),
                    SizedBox(height: 20),
                    Text(title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Organized by",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffA7A5A5))),
                        Text(" $organized",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFFD651))),
                      ],
                    ),
                    SizedBox(height: 15),
                    // Cstum Proggres Bar
                    ProggresBarWidget(
                        progress: 0.7,
                        filledColor: Color(0xff3B91CF),
                        emptyColor: Color(0xffD9D9D9),
                        persentage: '70%'),
                    SizedBox(height: 13),
                    // Text(value,
                    //     style: TextStyle(
                    //         fontSize: 8, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Collected from Rp.$goal",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffA7A5A5))),
                        Text("Until $duration",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffA7A5A5))),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text("Description",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 9),
                    Text(description,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            MyButton(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Payment(images: images, title: title)),
                );
              },
              text: "Donate Now",
            ),
          ],
        ),
      ),
    );
  }
}

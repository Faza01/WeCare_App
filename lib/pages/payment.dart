// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wecare/components/formfields/my_formfield.dart';
import 'package:wecare/pages/method.dart';
import 'package:wecare/widgets/appBarGoBack.dart';

import '../components/buttons/my_button.dart';

class Payment extends StatelessWidget {
  Payment({required this.title, required this.images});
  final String title;
  final String images;
  final nominalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarGoBack(
            title: 'Payment',
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 29),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 55,
                    width: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/lg_wecare.png'),
                            fit: BoxFit.cover))),
                SizedBox(height: 32),
                Stack(
                  children: [
                    Positioned(
                        child: Material(
                      color: Color(0xffE7E6E6),
                      child: Container(
                        height: 109,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            )),
                      ),
                    )),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: SizedBox(
                        height: 70,
                        width: 55,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: (Image.network(
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
                          )),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 15,
                        left: 90,
                        child: SizedBox(
                          width: 201,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Donasi Untuk",
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        )),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 127,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Masukan Nominal Donasi',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff545050),
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        MyFormField(controller: nominalController, prefixText: 'Rp.', keyboardType: () => TextInputType.number,),
                        SizedBox(height: 6),
                        Text('Jumlah donasi minilal Rp 10.000',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff858484),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                MyButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentMethod(),
                      ),
                    );
                  },
                  text: "Continue Payment",
                ),
              ],
            ),
          )),
        ));
  }
}

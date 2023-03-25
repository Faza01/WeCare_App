// ignore_for_file: prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:wecare/home.dart';
import 'package:wecare/widgets/appBarGoBack.dart';
import '../components/buttons/my_button.dart';
import '../components/formfields/my_formfield.dart';

class PaymentMethod extends StatelessWidget {
  PaymentMethod({Key? key}) : super(key: key);
  final nominalController = TextEditingController();
  final List<String> genderItems = [
    'Dana',
    'Gopay',
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarGoBack(
            title: 'Payment',
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 29),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                        height: 55,
                        width: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/lg_wecare.png'),
                                fit: BoxFit.cover))),
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
                          MyFormField(
                              controller: nominalController, prefixText: 'Rp.', keyboardType: () => TextInputType.number,),
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
                  Text('Donation Method',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff545050),
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Select Your Method',
                      style: TextStyle(fontSize: 14),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: genderItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select method.';
                      }
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                  ),
                  SizedBox(height: 20),
                  MyButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      }
                    },
                    text: "Continue",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

// ignore_for_file: prefer__ructors, prefer_const_constructors
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wecare/components/formfields/my_datepicker.dart';
import 'package:wecare/components/formfields/my_formfield.dart';
import 'package:wecare/pages/message.dart';
import 'package:wecare/widgets/appBar.dart';
import 'package:wecare/widgets/appBarGoBack.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../components/buttons/my_button.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  // text editing controllers
  final titleController = TextEditingController();
  final organizedController = TextEditingController();
  final descriptionController = TextEditingController();
  final goalController = TextEditingController();
  final durationController = TextEditingController();

  // // Image Picker Widget
  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff3B91CF)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff3B91CF)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // validation
  final _formKey = GlobalKey<FormState>();

  void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    // Get the values from image picker
    final path = 'images/${image!.name}';
    final file = File(image!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    // Show progress indicator while uploading
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Uploading image...'),
              ],
            ),
          ),
        ),
      ),
    );

    // Upload image file to Firebase Storage
    try {
      final task = ref.putFile(file);

      // Update progress indicator as file uploads
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = snapshot.bytesTransferred / snapshot.totalBytes;
        print('Upload progress: $progress');
      });

      final taskSnapshot = await task;

      // Generate download URL for the uploaded file
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Get the values from the text controllers
      String title = titleController.text;
      String organized = organizedController.text;
      String description = descriptionController.text;
      String goal = goalController.text;
      String duration = durationController.text;

      // Add user details to Firestore
      await FirebaseFirestore.instance.collection('donations').add({
        'title': title,
        'organized': organized,
        'description': description,
        'goal': goal,
        'duration': duration,
        'downloadUrl': downloadUrl,
      });

      // Close progress indicator
      Navigator.pop(context);

      // Show success message
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text('Form submitted successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );

    } catch (e) {
      // Close progress indicator
      Navigator.pop(context);

      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text('Error uploading image: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
  // // Date Format Message
  //     // DateTime now = DateTime.now();
  //     // String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  //     // // Add message
  //     // FirebaseFirestore.instance.collection('messages').add(
  //     //     {'message': 'Donasi Berhasil Dibuat', 'timestamp': formattedDate});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // Costum App Bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWidget(
          title: 'Galang Dana',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(29),
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form
              Text.rich(
                TextSpan(
                    text: 'Create your fundriser',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: TextStyle(fontSize: 16),
              ),

              //Title
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                    text: 'Title',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              MyFormField(controller: titleController),
              //Organized by
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                    text: 'Organized by',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              MyFormField(controller: organizedController),
              // Description
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                    text: 'Description',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              MyFormField(controller: descriptionController),
              // Image
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                    text: 'Image',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    myAlert();
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(width: 1, color: Colors.grey),
                    padding: EdgeInsets.all(2),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Material(
                    child: InkWell(
                      child: image != null
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: FileImage(File(image!.path)),
                                      fit: BoxFit.cover)),
                            )
                          : Text(
                              "*Select Image",
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                      onTap: () {
                        myAlert();
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                    text: 'goal',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              MyFormField(
                controller: goalController,
                prefixText: 'Rp.',
                keyboardType: () => TextInputType.number,
              ),
              //Duration
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                    text: 'Duration',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              MyDatePicker(controller: durationController),

              SizedBox(height: 32),
              //button
              MyButton(
                onTap: _submitForm,
                // () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => Message(),
                //       ),
                //     );
                //   },
                text: "Galang Dana",
              ),
              SizedBox(height: 20)
            ],
          ),
        )),
      ),
    ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FumgnPage extends StatefulWidget {
  @override
  State<FumgnPage> createState() => _FumigationPageState();
}

class _FumigationPageState extends State<FumgnPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _educationController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  void savetask() async {
    final clientName = _nameController.text;
    final clientAge = _ageController.text;
    final clientPlace = _placeController.text;
    final clientMobilenumber = _mobileNumberController.text;
    final clientEmail = _emailController.text;
    final clientEducation = _educationController.text;

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String? userIds = firebaseAuth.currentUser?.uid;
    FirebaseFirestore.instance.collection('users').doc(userIds).set({
      "Name": clientName,
      "Age": clientAge,
      "Place": clientPlace,
      "Mobile No": clientMobilenumber,
      "Email": clientEmail,
      "Quallification": clientEducation
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 2,
          centerTitle: true,
          title: Text(
            "Fumigation",
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
            // Your previous code here
            ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            onPressed: () {
              _showRegistrationBottomSheet(context);
            },
            label: Text('Registration Here'),
            icon: Icon(Icons.add),
          ),
        ));
  }

  void _showRegistrationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Register Now',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                    ),
                    controller: _ageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Place',
                    ),
                    controller: _placeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your place';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number',
                    ),
                    controller: _mobileNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Education',
                    ),
                    controller: _educationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your education';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If all validations pass, submit the form.
                        // _submitRegistrationForm();
                        print(_nameController.text);
                      }
                      savetask();
                    },
                    child: const Text('Register Now'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

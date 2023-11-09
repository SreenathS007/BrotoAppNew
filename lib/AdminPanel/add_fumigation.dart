import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddFumigation extends StatefulWidget {
  @override
  State<AddFumigation> createState() => _AddFumigationState();
}

class _AddFumigationState extends State<AddFumigation> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _batchController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
//firebase storing the data

  FirebaseAuth auth = FirebaseAuth.instance;

  void addFumigation() async {
    final fumLocation = _locationController.text;
    final fumBatchNum = _batchController.text;
    final fumDate = _dateController.text;
    final fumDescription = _descriptionController.text;

    if (fumLocation.isEmpty ||
        fumBatchNum.isEmpty ||
        fumDate.isEmpty ||
        fumDescription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Fill All the Fields Above'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String? fumgationIds = firebaseAuth.currentUser?.uid;
    FirebaseFirestore.instance.collection('fumigation').doc(fumgationIds).set({
      "Location": fumLocation,
      "Batch Number": fumBatchNum,
      "Fumigation Date": fumDate,
      "Description": fumDescription
    });
    _locationController.clear();
    _batchController.clear();
    _dateController.clear();
    _descriptionController.clear();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = dateFormat.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Fumigation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const Text(
                //   'Add a New Fumigation',
                //   style: TextStyle(
                //     fontSize: 20.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                  ),
                  controller: _locationController,
                  onChanged: (value) {
                    // Update the location value
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a batch number';
                    }
                    return null;
                  },
                  maxLength: 6,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Batch Number',
                  ),
                  controller: _batchController,
                  onChanged: (value) {
                    // Update the type value
                  },
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () async {
                    await _selectDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date (dd-MM-yyyy)',
                      ),
                      controller: _dateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  maxLines: 4, // Adjust the number of lines as needed
                  controller: _descriptionController,
                  onChanged: (value) {
                    // Update the description value
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Add the fumigation logic
                      Navigator.of(context).pop();
                    }
                    addFumigation();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

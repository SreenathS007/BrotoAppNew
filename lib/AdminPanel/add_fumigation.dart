import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FumigationData {
  final String location;
  final String batchNumber;
  final String date;
  final String description;

  FumigationData({
    required this.location,
    required this.batchNumber,
    required this.date,
    required this.description,
  });
}

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

  List<FumigationData> fumigationList = [];

  FirebaseAuth auth = FirebaseAuth.instance;

  void getFumigationData() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('fumigation').get();
    snapshot.docs.forEach((document) {
      setState(() {
        fumigationList.add(
          FumigationData(
            location: document['Location'],
            batchNumber: document['Batch Number'],
            date: document['Fumigation Date'],
            description: document['Description'],
          ),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getFumigationData();
  }

  void addFumigation() {
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

    FirebaseFirestore.instance.collection('fumigation').add({
      'Location': fumLocation,
      'Batch Number': fumBatchNum,
      'Fumigation Date': fumDate,
      'Description': fumDescription,
    }).then((value) {
      setState(() {
        fumigationList.add(
          FumigationData(
            location: fumLocation,
            batchNumber: fumBatchNum,
            date: fumDate,
            description: fumDescription,
          ),
        );
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Data added successfully.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }).catchError((error) {
      print("Failed to add data: $error");
    });

    _locationController.clear();
    _batchController.clear();
    _dateController.clear();
    _descriptionController.clear();
  }

  void deleteFumigation(int index) {
    String docId = fumigationList[index]
        .location; // You should use a unique identifier here

    FirebaseFirestore.instance
        .collection('fumigation')
        .where('Location', isEqualTo: docId)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete().then((value) {
        setState(() {
          fumigationList.removeAt(index);
        });
      }).catchError((error) {
        print("Failed to delete data: $error");
      });
    });
  }

  Widget _buildFumigationCard(FumigationData data, int index) {
    return Card(
      color: Colors.teal[100],
      child: ListTile(
        title: Text(data.location),
        subtitle: Text(data.description),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirm'),
                  content: Text('Do you want to delete this item?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        deleteFumigation(index);
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
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
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a batch number';
                    }
                    return null;
                  },
                  maxLength: 7,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Batch Number',
                  ),
                  controller: _batchController,
                  onChanged: (value) {},
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
                  maxLines: 4,
                  controller: _descriptionController,
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      addFumigation();
                    }
                  },
                  child: Text('Add'),
                ),
                SizedBox(height: 16.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: fumigationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildFumigationCard(fumigationList[index], index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

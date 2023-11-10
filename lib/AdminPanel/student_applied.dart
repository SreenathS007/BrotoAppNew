import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentApplied extends StatefulWidget {
  @override
  State<StudentApplied> createState() => _StudentAppliedState();
}

class _StudentAppliedState extends State<StudentApplied> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Student Applied'),
      ),
      //firebase  operationssree@gmail.com
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Connection error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }

          var docs = snapshot.data?.docs;

          if (docs != null) {
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                var data = docs[index].data() as Map<String, dynamic>;
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[200], // Set the light shade color here
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${data['Name']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          SizedBox(height: 8.0),
                          Text("Age: ${data['Age']}"),
                          Text("Mobile Number: ${data['Mobile No']}"),
                          Text("Email: ${data['Email']}"),
                          Text("Place: ${data['Place']}"),
                          Text("Qualification: ${data['Quallification']}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Text(
                "No data available"); // Handle the case when there's no data
          }
        },
      ),
    );
  }
}

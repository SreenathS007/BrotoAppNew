import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({Key? key}) : super(key: key);

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _venueController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void addEvent() async {
    final EventName = _eventNameController.text;
    final EventVenue = _venueController.text;
    final EventTime = _timeController.text;

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String? userId = firebaseAuth.currentUser?.uid;

    // Check if the user already has an event
    var existingEvent =
        await FirebaseFirestore.instance.collection("Events").doc(userId).get();

    if (existingEvent.exists) {
      // Update the existing event

      await FirebaseFirestore.instance.collection("Events").doc(userId).update({
        "Event Name": EventName,
        "Event Venue": EventVenue,
        "Event Time": EventTime,
      });
    } else {
      // Add a new event
      await FirebaseFirestore.instance.collection("Events").doc(userId).set({
        "Event Name": EventName,
        "Event Venue": EventVenue,
        "Event Time": EventTime,
      });
    }

    // Clear text fields after adding/updating the event
    _eventNameController.clear();
    _venueController.clear();
    _timeController.clear();

    // Force a rebuild to update the event list
    setState(() {});
  }

  void deleteEvent(String documentId) {
    FirebaseFirestore.instance.collection("Events").doc(documentId).delete();
  }

  Future<void> _confirmDeleteDialog(String documentId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this event?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteEvent(documentId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Events"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _eventNameController,
                    decoration: InputDecoration(labelText: 'Event Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the event name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _venueController,
                    decoration: InputDecoration(labelText: 'Venue'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the venue';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _timeController,
                    decoration: InputDecoration(labelText: 'Time'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the time';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform your action with the collected data
                        print(
                            'Event Name: ${_eventNameController.text}, Venue: ${_venueController.text}, Time: ${_timeController.text}');
                        addEvent();
                      }
                    },
                    child: Text('Add Event'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Events").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var event = snapshot.data!.docs[index];
                    return Container(
                      height: 150,
                      child: Card(
                        color:
                            Colors.red[200], // You can customize the color here
                        child: ListTile(
                          title: Text(
                            event["Event Name"],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Venue: ${event["Event Venue"]}",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Time: ${event["Event Time"]}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () {
                              _confirmDeleteDialog(event.id);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Eventpage extends StatelessWidget {
  const Eventpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Events'),
      ),
      body: Container(
        color: Colors
            .red[200], // You can replace Colors.blue with your preferred color
      ),
    );
  }
}

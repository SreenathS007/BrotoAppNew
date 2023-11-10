import 'package:flutter/material.dart';

class SuccesStories_Add extends StatefulWidget {
  const SuccesStories_Add({super.key});

  @override
  State<SuccesStories_Add> createState() => _SuccesStories_AddState();
}

class _SuccesStories_AddState extends State<SuccesStories_Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Success Stories"),
      ),
    );
  }
}

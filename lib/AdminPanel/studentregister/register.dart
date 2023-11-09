import 'package:brototype_app/AdminPanel/studentregister/add_student.dart';
import 'package:brototype_app/AdminPanel/studentregister/list_data.dart';
import 'package:brototype_app/AdminPanel/studentregister/search.dart';
import 'package:brototype_app/database/functions/function/adminFunctions/register_std_function.dart';
import 'package:flutter/material.dart';

class student_register extends StatefulWidget {
  const student_register({super.key});

  @override
  State<student_register> createState() => _student_registerState();
}

class _student_registerState extends State<student_register> {
  @override
  Widget build(BuildContext context) {
    getallstudents();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Student Details'),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: ScreenSearch(),
                  );
                },
                child: const Icon(
                  Icons.search,
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => ScreenAdd()));
        },
        tooltip: 'Add Student',
        child: const Icon(Icons.add),
      ),
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListStudent(),
      )),
    );
  }
}

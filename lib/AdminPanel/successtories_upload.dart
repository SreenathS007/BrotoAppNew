import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SuccesStories_Add extends StatefulWidget {
  const SuccesStories_Add({Key? key}) : super(key: key);

  @override
  State<SuccesStories_Add> createState() => _SuccesStories_AddState();
}

class _SuccesStories_AddState extends State<SuccesStories_Add> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future uploadFile() async {
    try {
      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      await uploadTask!.whenComplete(() => {});

      final urlDownload = await ref.getDownloadURL();
      print('Download Link: $urlDownload');

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Success'),
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Successfully added.'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );

      setState(() {
        pickedFile = null;
        uploadTask = null;
      });
    } catch (error) {
      print('Error uploading file: $error');
      // Handle error if needed
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Success Stories"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: pickedFile != null
                    ? GestureDetector(
                        onTap: selectFile,
                        child: Image.file(
                          File(pickedFile!.path!),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectFile,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 50, color: Colors.blue),
                            SizedBox(height: 8),
                            Text("Upload Video"),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text("Select File"),
                onPressed: selectFile,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text("Upload File"),
                onPressed: uploadFile,
              ),
            ],
          ),
        ),
      );
}

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SuccesStories_Add extends StatefulWidget {
  const SuccesStories_Add({Key? key}) : super(key: key);

  @override
  State<SuccesStories_Add> createState() => _SuccessStoriesAddState();
}

class _SuccessStoriesAddState extends State<SuccesStories_Add> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

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
                    ? Image.file(File(pickedFile!.path!))
                    : GestureDetector(
                        onTap: selectFile,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_rounded,
                                size: 50, color: Colors.blue),
                            SizedBox(height: 8),
                            Text("Upload Image"),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text("Select Image"),
                onPressed: selectFile,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text("Upload Image"),
                onPressed: uploadFile,
              ),
            ],
          ),
        ),
      );

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'gif'
      ], // Add your desired image file extensions
    );

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    try {
      if (pickedFile == null) {
        // Handle case where no file is selected
        return;
      }

      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 8),
              Text('Uploading...'),
            ],
          ),
        ),
      );

      await uploadTask!.whenComplete(() => {});

      Navigator.of(context).pop(); // Close loading indicator dialog

      final urlDownload = await ref.getDownloadURL();
      print('Download Link: $urlDownload');

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Row(
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
              child: const Text('OK'),
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

      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred while uploading the file.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

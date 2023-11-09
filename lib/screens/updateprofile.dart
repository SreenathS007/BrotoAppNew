import 'dart:io';

import 'package:brototype_app/custom_widgets/bottomNavbar.dart';
import 'package:brototype_app/database/functions/function/userFunctions/signup_function.dart';
import 'package:brototype_app/database/functions/models/signup_model.dart';
import 'package:brototype_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Updateprofile extends StatefulWidget {
  const Updateprofile({super.key});

  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

final _emailController = TextEditingController();
final _nameController = TextEditingController();
final _ageController = TextEditingController();

class _UpdateprofileState extends State<Updateprofile> {
  late int selectedRadio;
  @override
  void initState() {
    selectedRadio = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadValuesToCtrl();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 120),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () async => await getPhoto(),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: ValueListenableBuilder(
                      valueListenable: imgPath,
                      builder: (BuildContext context, file, _) {
                        return imgPath.value.isEmpty
                            ? Image.asset(
                                'assets/images/stdprofile.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(file),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              );
                      },
                    )),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Your name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Your email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Phone',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Your Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () async {
                    HiveDb db = HiveDb();
                    Box userBox = await Hive.openBox(db.userBoxKey);
                    final sharedPrefs = await SharedPreferences.getInstance();
                    String? email = sharedPrefs.getString(emailkeyName);
                    UserdataModal user = await userBox.get(email);

                    // _nameController.text = user.name;
                    // _emailController.text = user.email;
                    // _ageController.text = user.age;

                    user_name = _nameController.text;
                    user_email = _emailController.text;
                    user_password = _ageController.text;
                    String user_imgPath =
                        imgPath.value.isNotEmpty ? imgPath.value : '';

                    print(_emailController.text);
                    print(user_email);

                    // await userBox.put(email, user);

                    UserdataModal newModel = UserdataModal(
                      username: user_name,
                      email: user_email,
                      phone: user.phone,
                      cnfmpassword: user.cnfmpassword,
                      imgPath: user_imgPath,
                    );

                    await userBox.delete(email);
                    await userBox.put(user_email, newModel);
                    await sharedPrefs.setString(emailkeyName, user_email);

                    _emailController.clear();
                    _nameController.clear();
                    _ageController.clear();
                    Get.to(() => const bottomNavBar());
                  },
                  child: const Text('UPDATE')),
            ],
          ),
        ),
      ),
    );
  }

  loadValuesToCtrl() async {
    HiveDb db = HiveDb();
    Box userBox = await Hive.openBox(db.userBoxKey);
    final sharedPrefs = await SharedPreferences.getInstance();
    String? email = sharedPrefs.getString(emailkeyName);
    UserdataModal user = await userBox.get(email);

    _nameController.text = user.username;
    _emailController.text = user.email;
    _ageController.text = user.phone;

    user_name = _nameController.text;
    user_email = _emailController.text;
    user_password = _ageController.text;
  }

  final picker = ImagePicker();
//Image Picker function to get image from gallery
  Future getPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imgPath.value = pickedFile.path;
      imgPath.notifyListeners();
    } else {
      print('not found');
    }
  }
}

// import 'package:firebase_core/firebase_core.dart';
import 'package:brototype_app/custom_widgets/bottomNavbar.dart';
import 'package:brototype_app/AdminPanel/adminlogin.dart';
import 'package:brototype_app/database/functions/function/userFunctions/signup_function.dart';
import 'package:brototype_app/database/functions/models/signup_model.dart';
import 'package:brototype_app/home.dart';
import 'package:brototype_app/main.dart';
import 'package:flutter/material.dart';
import 'package:brototype_app/screens/signupage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            const Image(
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              image: AssetImage('assets/images/logimg.png'),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.5)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email Adress',
                        label: Text('Email Adress'),
                        fillColor: Color(0xffD8D8DD),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        label: Text('Password'),
                        suffixIcon: Icon(Icons.visibility_off),
                        fillColor: Color(0xffD8D8DD),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: 290,
                    decoration: const BoxDecoration(
                      color: Color(0xff0ACF83),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff0ACF83)),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80.0, top: 30),
                    child: Row(
                      children: [
                        const Text(
                          "Don't have any account?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          ),
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80.0, top: 30),
                    child: Row(
                      children: [
                        const Text(
                          "Go for Admin Account ?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminLogin(),
                            ),
                          ),
                          child: const Text(
                            "Admin Login",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    // if (formKey.currentState!.validate()) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    HiveDb db = HiveDb();
    Box userBox = await Hive.openBox(db.userBoxKey);

    UserdataModal? user = await userBox.get(email);

    if (user != null) {
      print('logginn');
      if (password == user.cnfmpassword) {
        print("true");
        Get.to(() => bottomNavBar());

        final sharedprefs = await SharedPreferences.getInstance();
        await sharedprefs.setString(emailkeyName, email);

        await sharedprefs.setBool(savekeyName, true);
      }
    } else {
      print("Existing emails");
      print(userBox.keys);
      Get.snackbar('user not Exists', '');
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => bottomNavBar()),
    // );
    // }
  }
}

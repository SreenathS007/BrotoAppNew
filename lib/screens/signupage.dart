import 'package:brototype_app/custom_widgets/bottomNavbar.dart';
import 'package:brototype_app/database/functions/function/userFunctions/signup_function.dart';
import 'package:brototype_app/database/functions/models/signup_model.dart';
import 'package:brototype_app/main.dart';
import 'package:flutter/material.dart';
import 'package:brototype_app/screens/loginpage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cnfmpasswordController = TextEditingController();

  bool _isObscure = true;
  bool _isCnfObscure = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _toggleCnfPasswordVisibility() {
    setState(() {
      _isCnfObscure = !_isCnfObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'SignUp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: 'User Name',
                          label: Text('User Name'),
                          fillColor: Color(0xffD8D8DD),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'User name Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
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
                            return 'Email is Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(25.0),
                      child: TextFormField(
                        maxLength: 10,
                        // obscureText: _isObscure,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Phone ',
                          label: Text('phone Number'),
                          fillColor: Color(0xffD8D8DD),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone Number Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: TextFormField(
                        obscureText: _isCnfObscure,
                        controller: _cnfmpasswordController,
                        decoration: InputDecoration(
                          hintText: ' Password',
                          label: Text('Password'),
                          suffixIcon: IconButton(
                            icon: _isCnfObscure
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: _toggleCnfPasswordVisibility,
                          ),
                          fillColor: Color(0xffD8D8DD),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password Required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: 290,
                      decoration: const BoxDecoration(
                        color: Color(0xff0ACF83),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          signup();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff0ACF83)),
                        ),
                        child: const Center(
                          child: Text(
                            'Signup',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0, top: 30),
                      child: Row(
                        children: [
                          const Text(
                            "Already have account?",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signup() async {
    // if (formKey.currentState!.validate()) {
    final userName = _usernameController.text;
    final Email = _emailController.text;
    final Password = _passwordController.text;
    final CnfmPassword = _cnfmpasswordController.text;

//adding to database
    if (formKey.currentState!.validate()) {
      HiveDb db = HiveDb();
      Box userBox = await Hive.openBox(db.userBoxKey);

      UserdataModal? user = await userBox.get(Email);

      if (userName.isNotEmpty &&
          Email.isNotEmpty &&
          Password.isNotEmpty &&
          CnfmPassword.isNotEmpty) {
        if (user != null) {
          Get.snackbar('user exists', '');
        } else {
          UserdataModal model = UserdataModal(
              username: userName,
              email: Email,
              phone: Password,
              cnfmpassword: CnfmPassword);
          userBox.put(Email, model);

          final sharedprefs = await SharedPreferences.getInstance();
          await sharedprefs.setString(emailkeyName, model.email);
          await sharedprefs.setBool(savekeyName, true);

          /////////
          await userBox.close();
          Get.to(() => bottomNavBar());
        }
      } else {
        Get.snackbar("fill the Fields", '');
        //}
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => bottomNavBar()),
        // );
      }
    }
  }
}

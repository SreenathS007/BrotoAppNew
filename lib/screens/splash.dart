import 'dart:async';
import 'package:brototype_app/AdminPanel/adminlogin.dart';
import 'package:brototype_app/custom_widgets/bottomNavbar.dart';
import 'package:brototype_app/main.dart';
import 'package:brototype_app/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    CheckUserLogedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/sp.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset(
              'assets/images/SPlashIcon.png',
              height: 300,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> GotoLogin() async {
    await Future.delayed(Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => LoginScreen(),
      ),
    );
  }

  Future<void> CheckUserLogedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();

    final _userLogedIn = _sharedPrefs.getBool(savekeyName);

    if (_userLogedIn == null || _userLogedIn == false) {
      GotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx1) => bottomNavBar(),
        ),
      );
    }
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:brototype_app/AdminPanel/adminlogin.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => AdminLogin(),
        ),
      );
    });
  }

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
              'assets/images/brotoLogo.webp',
              height: 300,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}

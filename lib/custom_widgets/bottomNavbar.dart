import 'package:brototype_app/database/functions/function/userFunctions/signup_function.dart';
import 'package:brototype_app/database/functions/models/signup_model.dart';
import 'package:brototype_app/home.dart';
import 'package:brototype_app/main.dart';
import 'package:brototype_app/screens/profile.dart';
import 'package:brototype_app/screens/search_bar.dart';
import 'package:brototype_app/screens/userside/stories.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

String user_name = 'name';
String user_email = 'email';
String user_password = 'password';

class bottomNavBar extends StatefulWidget {
  const bottomNavBar({super.key});

  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  int _currentIndex = 0;
  List<Widget> bottomList = [
    const HomeScreen(),
    const SearchBar(),
    const StoryPage(),
    const ProfilePage(),
  ];
  getUserDatas() async {
    HiveDb db = HiveDb();
    Box userBox = await Hive.openBox(db.userBoxKey);
    final sharedPrefs = await SharedPreferences.getInstance();
    String? email = sharedPrefs.getString(emailkeyName);

    UserdataModal user = await userBox.get(email);
    user_name = user.username;
    user_email = user.email;
    user_password = user.phone;
  }

  @override
  void initState() {
    getUserDatas();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomList[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.video_collection),
          Icon(Icons.account_box),
        ],
      ),
    );
  }
}

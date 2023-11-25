import 'dart:io';
import 'package:brototype_app/main.dart';
import 'package:brototype_app/screens/userside/menubar/faqs.dart';
import 'package:brototype_app/screens/updateprofile.dart';
import 'package:brototype_app/screens/userside/menubar/privacypolicy.dart';
import 'package:flutter/material.dart';
import 'package:brototype_app/screens/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  final String userName;
  final String userEmail;

  NavBar({required this.userName, required this.userEmail, Key? key})
      : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late String userName;
  late String userEmail;

  @override
  void initState() {
    super.initState();
    userName = widget.userName;
    userEmail = widget.userEmail;
  }

  void UpdateUserInfo(String newName, String newEmail) {
    setState(() {
      userName = newName;
      userEmail = newEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.userName),
            accountEmail: Text(widget.userEmail),
            currentAccountPicture: CircleAvatar(
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
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/coverpic.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: Text('Profile Settings'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Updateprofile(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text('FAQs'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FAQsPage(),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy & Policy'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrivacyPolicy(),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('LogOut'),
              onTap: () {
                signout(context);
              }
              // => Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => LoginScreen(),
              //   ),
              // ),
              ),
        ],
      ),
    );
  }

  signout(BuildContext ctx) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();

    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => LoginScreen()), (route) => false);
  }
}

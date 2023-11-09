import 'package:brototype_app/AdminPanel/add_fumigation.dart';
import 'package:brototype_app/AdminPanel/codingvideo/video_list.dart';
import 'package:brototype_app/AdminPanel/student_applied.dart';
import 'package:brototype_app/AdminPanel/studentregister/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brototype_app/AdminPanel/adminlogin.dart';

class admin_Dashboard extends StatefulWidget {
  const admin_Dashboard({super.key});

  @override
  State<admin_Dashboard> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<admin_Dashboard> {
  void _logout() {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: const Text('confirm Logout'),
            content: const Text('Are you sure want to Logout?'),
            actions: <Widget>[
              TextButton(
                child: const Text('cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: Text("Logout"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx2) => AdminLogin(),
                      ),
                    );
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    "Admin Panel",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "Brototype",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white54),
                  ),
                  leading: const CircleAvatar(
                    radius: 29,
                    backgroundImage: AssetImage("assets/images/FAQsIcon.jpg"),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    color: Colors.black,
                    onPressed: _logout,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard(
                    'coding videos',
                    CupertinoIcons.play_rectangle,
                    Colors.deepOrange,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ShowVedioDetails(),
                        ),
                      );
                    },
                  ),
                  // itemDashboard(
                  //   'Hub Details',
                  //   CupertinoIcons.location_circle,
                  //   Colors.pinkAccent,
                  //   // onTap: () {
                  //   //   Navigator.of(context).push(
                  //   //     MaterialPageRoute(
                  //   //       builder: (context) => add_Hubs(),
                  //   //     ),
                  //   //   );
                  //   // },
                  // ),
                  itemDashboard(
                    'Registers',
                    CupertinoIcons.person_3,
                    Colors.purple,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const student_register(),
                        ),
                      );
                    },
                  ),
                  itemDashboard(
                    'Fumigation',
                    CupertinoIcons.square_list,
                    Colors.teal,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddFumigation(),
                        ),
                      );
                    },
                  ),
                  itemDashboard(
                    'student Applied',
                    CupertinoIcons.person_2,
                    Colors.blue,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentApplied(),
                        ),
                      );
                    },
                  ),
                  // itemDashboard(
                  //   'Upload',
                  //   CupertinoIcons.add_circled,
                  //   Colors.green,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background,
          {VoidCallback? onTap}) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: background, shape: BoxShape.circle),
                child: Icon(iconData, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      );
}

import 'package:brototype_app/custom_widgets/bottomNavbar.dart';
import 'package:flutter/material.dart';
import 'package:brototype_app/Hubs/calicuthub.dart';
import 'package:brototype_app/Hubs/kochihub.dart';
import 'package:brototype_app/Hubs/banglrhub.dart';
import 'package:brototype_app/Hubs/tvmhub.dart';

class HubPage extends StatelessWidget {
  HubPage({Key? key});

  // Define a list of hub data
  final List<HubData> hubs = [
    HubData('Calicut Hub', [Colors.blueAccent, Colors.indigo], CalicutHub()),
    HubData('Kochi Hub', [Colors.orange, Colors.yellow], KochiHub()),
    HubData('Bangalore Hub', [Colors.pink, Colors.red], BanglrHub()),
    HubData('Trivandrum Hub', [Colors.purple, Colors.purpleAccent], TvmHub()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Hubs',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx2) => bottomNavBar(),
              ),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.only(top: 30, right: 15),
          child: Column(
            children: hubs.map(
              (hub) {
                return Column(
                  children: [
                    HubCard(
                      hubName: hub.name,
                      colors: hub.gradientColors,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => hub.page,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                  ],
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

class HubData {
  final String name;
  final List<Color> gradientColors;
  final StatelessWidget page;

  HubData(this.name, this.gradientColors, this.page);
}

class HubCard extends StatelessWidget {
  final String hubName;
  final List<Color> colors;
  final VoidCallback onTap;

  const HubCard({
    required this.hubName,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: colors[0],
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: colors,
            ),
          ),
          child: Center(
            child: Text(
              hubName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

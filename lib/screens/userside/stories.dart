import 'package:flutter/material.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success Stories'),
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // No text or icons here
              ],
            ),
          ),
          GridView.count(
            childAspectRatio: 0.68,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics:
                NeverScrollableScrollPhysics(), // Disable GridView scrolling
            children: [
              for (int i = 1; i <= 10; i++)
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Add your onTap functionality here
                    },
                    // child: Container(
                    //   margin: const EdgeInsets.all(10),
                    //   height: 120,
                    //   width: 120,
                    //   color: Colors.grey[300], // Placeholder color
                    // ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Navigate back to the home page
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Success Stories',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
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
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
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

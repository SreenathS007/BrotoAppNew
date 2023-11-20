import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
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
      body: FutureBuilder<List<String>>(
        // Fetch the list of download URLs
        future: fetchDownloadURLs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<String> downloadURLs = snapshot.data!;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
              ),
              itemCount: downloadURLs.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10), // Adjust padding as needed
                  margin: const EdgeInsets.all(8), // Adjust margin as needed
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Add your onTap functionality here
                    },
                    child: Image.network(
                      downloadURLs[index],
                      fit: BoxFit.cover,
                      height: double
                          .infinity, // Make sure the image takes full height
                      width: double
                          .infinity, // Make sure the image takes full width
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> fetchDownloadURLs() async {
    // Fetch download URLs from Firebase Storage
    ListResult result = await FirebaseStorage.instance.ref('files').list();
    List<String> downloadURLs = [];

    for (Reference ref in result.items) {
      String url = await ref.getDownloadURL();
      downloadURLs.add(url);
    }

    return downloadURLs;
  }
}

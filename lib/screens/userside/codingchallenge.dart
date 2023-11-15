import 'package:brototype_app/AdminPanel/codingvideo/play_video_screen.dart';
import 'package:brototype_app/database/functions/function/adminFunctions/videoAdd_function.dart';
import 'package:brototype_app/database/functions/models/adminmodel/video_add_model.dart';
import 'package:flutter/material.dart';

List<String> imagePaths = [
  'assets/images/cdg1.jpg',
  'assets/images/cdg2.jpg',
  'assets/images/cdg3.jpg',
  'assets/images/cdg4.jpg',
  'assets/images/cdg5.jpg',
  'assets/images/cdg6.jpg',
  'assets/images/cdg7.jpg',
  'assets/images/cdg8.jpg',
  'assets/images/cdg9.jpg',
  'assets/images/cdg10.jpg',
];

class CodinChllge extends StatefulWidget {
  const CodinChllge({super.key});

  @override
  State<CodinChllge> createState() => _CodinChllgeState();
}

class _CodinChllgeState extends State<CodinChllge> {
  @override
  void initState() {
    updateVideoListNotifier();
    super.initState();
  }

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
        title: const Text(
          "Coding Challenges",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<VideoModel>>(
        valueListenable: videoListNotifier,
        builder: (context, videoList, child) {
          if (videoList.isEmpty) {
            return Center(
              child: Text(
                "No videos Added.!!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(
                            videoLink: videoList[index].link,
                            title: videoList[index].title),
                      ));
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 19, 30, 36),
                      elevation: 4,
                      child: Row(
                        children: [
                          Image.asset(
                            imagePaths[index],
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    videoList[index].title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    videoList[index].link,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
}

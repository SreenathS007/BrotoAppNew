import 'package:brototype_app/database/functions/models/search_model.dart';
import 'package:flutter/material.dart';

class search_Bar extends StatefulWidget {
  const search_Bar({super.key});

  @override
  State<search_Bar> createState() => _search_BarState();
}

class _search_BarState extends State<search_Bar> {
  final List<String> profileImage = [
    "assets/images/cdg1.jpg",
    "assets/images/cdg2.jpg",
    "assets/images/cdg3.jpg",
    "assets/images/cdg4.jpg",
    "assets/images/cdg5.jpg",
    "assets/images/cdg6.jpg",
    "assets/images/cdg7.jpg",
    "assets/images/cdg8.jpg",
    "assets/images/cdg9.jpg",
    "assets/images/cdg10.jpg",
  ];
  static List<VideoModel> video_List = [
    VideoModel("100K coding Challenge",
        "https://youtu.be/pDmEYRhyusU?si=meHYiHRrzVfF3XYS"),
    VideoModel('Web Designing Challenge',
        "https://youtu.be/KvaG1dWgwLk?si=83CQpe_FDRkdxykF"),
    VideoModel("Data Structure Challenge",
        "https://youtu.be/Bwx_0_VJZWw?si=g05QTqck0iVippcp"),
    VideoModel('Flutter Challenge',
        "https://youtu.be/KvaG1dWgwLk?si=83CQpe_FDRkdxykF"),
    VideoModel(
        'python Challenge', "https://youtu.be/KvaG1dWgwLk?si=83CQpe_FDRkdxykF"),
    VideoModel(
        "React Challenge", "https://youtu.be/KvaG1dWgwLk?si=83CQpe_FDRkdxykF"),
    VideoModel('3hr Coding Challenge',
        "https://youtu.be/KvaG1dWgwLk?si=83CQpe_FDRkdxykF"),
    VideoModel(
        'Git Challenge', "https://youtu.be/KvaG1dWgwLk?si=83CQpe_FDRkdxykF"),
    VideoModel('Introduction webdesign',
        "https://youtu.be/KvaG1dWgwLk?si=83CQpe_FDRkdxykF"),
    VideoModel(
        'Hosting Tutorial', "https://youtu.be/KvaG1dWgwLk?si=83CQpe_FDRkdxykF"),
  ];

  List<VideoModel> display_List = List.from(video_List);
  void updateList(String value) {
    //this is the function that will filter our list
    setState(() {
      display_List = video_List
          .where((element) =>
              element.video_name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1545),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Search for a Video',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                onChanged: (value) => updateList(value),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff302360),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "eg:100 coding Challenge",
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.purple.shade900),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: display_List.length == 0
                    ? const Center(
                        child: Text(
                          "No Result Found",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.2,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        itemCount: display_List.length,
                        itemBuilder: (context, index) => ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          title: Text(
                            display_List[index].video_name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Image.asset(profileImage[index]),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

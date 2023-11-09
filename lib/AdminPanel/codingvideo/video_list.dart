import 'package:brototype_app/AdminPanel/codingvideo/play_video_screen.dart';
import 'package:brototype_app/database/functions/function/adminFunctions/videoAdd_function.dart';
import 'package:brototype_app/database/functions/models/adminmodel/video_add_model.dart';
import 'package:flutter/material.dart';

class ShowVedioDetails extends StatefulWidget {
  const ShowVedioDetails({super.key});

  @override
  State<ShowVedioDetails> createState() => _ShowVedioDetailsState();
}

class _ShowVedioDetailsState extends State<ShowVedioDetails> {
  @override
  void initState() {
    super.initState();
    updateVideoListNotifier();
  }

  Future<void> _showConfirmationDialog(String videoId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This will delete from your device!!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                deleteVideo(videoId);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Added Videos "),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Add Videos'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return MyDialog();
              },
            );
          },
        ),
        body: SafeArea(
            child: ValueListenableBuilder<List<VideoModel>>(
          valueListenable: videoListNotifier,
          builder: (context, videoList, child) {
            return ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[50],
                  child: ListTile(
                    title: Text(videoList[index].title),
                    subtitle: Text(videoList[index].link),
                    trailing: IconButton(
                        onPressed: () {
                          _showConfirmationDialog(videoList[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    onTap: () {
                      _navigateToVideoPlayer(
                          videoList[index].link, videoList[index].title);
                    },
                  ),
                );
              },
            );
          },
        )));
  }

  void _navigateToVideoPlayer(String videoLink, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            VideoPlayerScreen(videoLink: videoLink, title: title),
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final formKey = GlobalKey<FormState>();
  TextEditingController linkController = TextEditingController();

  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(title: Text('Add Video'), children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Add Title"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Title";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: linkController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Add link"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Link";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      addVideo(VideoModel(
                          title: titleController.text,
                          link: linkController.text,
                          id: DateTime.now()
                              .millisecondsSinceEpoch
                              .toString()));
                      setState(() {
                        linkController.clear();
                        titleController.clear();
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Submit')),
            ],
          ),
        ),
      ),
    ]);
  }
}

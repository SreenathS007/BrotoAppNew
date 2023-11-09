import 'package:brototype_app/database/functions/models/adminmodel/video_add_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<VideoModel>> videoListNotifier = ValueNotifier([]);

Future<void> addVideo(VideoModel value) async {
  final videoDB = await Hive.openBox<VideoModel>("video_db");

  videoDB.put(value.id, value);
  updateVideoListNotifier();
  videoListNotifier.notifyListeners();
}

Future<void> deleteVideo(String id) async {
  final videoDB = await Hive.openBox<VideoModel>("video_db");
  await videoDB.delete(id);
  await updateVideoListNotifier();
  videoListNotifier.notifyListeners();
}

Future<List<VideoModel>> fetchAllVideos() async {
  final videoDB = await Hive.openBox<VideoModel>("video_db");

  List<VideoModel> videoList = [];
  for (var i = 0; i < videoDB.length; i++) {
    videoList.add(videoDB.getAt(i)!);
  }

  return videoList;
}

Future<void> updateVideoListNotifier() async {
  List<VideoModel> fetchedVideoList = await fetchAllVideos();
  videoListNotifier.value = fetchedVideoList;
}

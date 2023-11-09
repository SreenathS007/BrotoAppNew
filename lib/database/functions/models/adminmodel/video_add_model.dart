import 'package:hive_flutter/adapters.dart';
part 'video_add_model.g.dart';

@HiveType(typeId: 2)
class VideoModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String link;

  VideoModel({
    required this.title,
    required this.link,
    required this.id,
  });
}

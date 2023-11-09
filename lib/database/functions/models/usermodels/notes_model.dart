import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 4)
class NoteModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late DateTime date;

  @HiveField(3)
  late int color;

  NoteModel({
    required this.title,
    required this.description,
    required this.date,
    required this.color,
  });
  NoteModel.copy(NoteModel other) {
    title = other.title;
    description = other.description;
    date = other.date;
    color = other.color;
  }
}

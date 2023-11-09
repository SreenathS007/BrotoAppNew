import 'package:brototype_app/database/functions/models/usermodels/notes_model.dart';
import 'package:hive/hive.dart';

class NoteController {
  final Box<NoteModel> _notesBox = Hive.box<NoteModel>("notes");

  //load the data from database
  Future<List<NoteModel>> getNotes() async {
    return _notesBox.values.toList();
  }
  //add data to database

  Future<void> addNote(NoteModel note) async {
    await _notesBox.add(note);
  }

  //edit the saved data

  Future<void> editNote(int index, NoteModel updatedNote) async {
    await _notesBox.putAt(index, updatedNote);
  }

  //delete the saved data

  Future<void> deleteNote(int index) async {
    await _notesBox.deleteAt(index);
  }
}

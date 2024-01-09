import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../features/tasks/presentation/dvo/note.dart';

abstract class NoteDatabase {
  Future<List<Note>> getNotes();

  Future<void> addNote(Note note);

  Future<void> deleteNote(String key);

  Future<bool> updateNote(Note note);
}

class NoteDatabaseImpl extends NoteDatabase {
  final _uuid = const Uuid();

  //get all data from the box
  @override
  Future<List<Note>> getNotes() async {
    final List<Note> notes = [];
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().toList();
    final notesJson = keys.map((key) => prefs.getString(key));
    final noteTitles = notesJson.map((note) => jsonDecode(note ?? ""));
    notes.addAll(
        noteTitles.map((note) => Note.fromJson(note as Map<String, dynamic>)));
    return notes;
  }

  //add data to the box
  @override
  Future<void> addNote(Note note) async {
    final noteKey = _uuid.v4();
    final prefs = await SharedPreferences.getInstance();
    final newNote = Note(noteKey, note.title);
    bool result = await prefs.setString(noteKey, jsonEncode(newNote.toJson()));
    result;
  }

  //delete data from the box
  @override
  Future<void> deleteNote(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  //update data from the box
  @override
  Future<bool> updateNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(note.id, jsonEncode(note.toJson()));
  }
}

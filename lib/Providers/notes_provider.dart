import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _notes = [];

  Future<List<Map<String, dynamic>>> getNotesFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedNotes = prefs.getString("Notes");

    if (encodedNotes != null) {
      return List<Map<String, dynamic>>.from(json.decode(encodedNotes));
    }
    return _notes = [];
  }

  Future<void> initNotesFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedNotes = prefs.getString("Notes");

    if (encodedNotes != null) {
      _notes = List<Map<String, dynamic>>.from(json.decode(encodedNotes));
    } else {
      _notes = [];
    }
  }

  Future<void> addNotesToLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedNotes = json.encode(_notes);
    prefs.setString('Notes', encodedNotes);
    initNotesFromLocalStorage();
  }

  void addNote(Map<String, dynamic> note) async {
    _notes.add(note);
    addNotesToLocalStorage();
    notifyListeners();
  }

  void deleteNote(Map<String, dynamic> note) {
    _notes.remove(note);
    addNotesToLocalStorage();
    notifyListeners();
  }

  void updateNote(int id, Map<String, dynamic> note) {
    _notes.removeAt(id);
    _notes.insert(id, note);
    addNotesToLocalStorage();
    notifyListeners();
  }
}

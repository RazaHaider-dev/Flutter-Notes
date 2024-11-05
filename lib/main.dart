import 'package:flutter/material.dart';
import 'package:notesapp/Providers/notes_provider.dart';
import 'package:notesapp/Widgets/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        return NotesProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home: const HomePage(),
      ),
    ),
  );
}

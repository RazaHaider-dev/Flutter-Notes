import 'package:flutter/material.dart';
import 'package:notesapp/Providers/notes_provider.dart';
import 'package:notesapp/Widgets/home_page.dart';
import 'package:provider/provider.dart';

class EditNote extends StatefulWidget {
  final Map<String, dynamic> note;
  final id;
  const EditNote({super.key, required this.note, this.id});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingControllerTitle =
        TextEditingController();
    final TextEditingController textEditingControllerDescription =
        TextEditingController();

    textEditingControllerTitle.text = widget.note['title'].toString();
    textEditingControllerDescription.text = widget.note['body'].toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Title",
              ),
              controller: textEditingControllerTitle,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "body",
              ),
              controller: textEditingControllerDescription,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map<String, dynamic> note = {
            "title": textEditingControllerTitle.text,
            "body": textEditingControllerDescription.text,
          };

          String msg = "";
          if (note["title"] == "" && note["body"] == "") {
            msg = "Can Not Craete an empty note";
          } else {
            Provider.of<NotesProvider>(context, listen: false)
                .updateNote(widget.id, note);
            msg = "Note Updated !";
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg),
            ),
          );

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

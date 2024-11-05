import 'package:flutter/material.dart';
import 'package:notesapp/Providers/notes_provider.dart';
import 'package:notesapp/Widgets/create_norte.dart';
import 'package:notesapp/Widgets/edit_notes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Provider.of<NotesProvider>(context)
                    .getNotesFromLocalStorage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    List<Map<String, dynamic>> notes = snapshot.data!;
                    return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return ListTile(
                          title: Text(
                            note['title'] as String,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            note['body'] as String,
                            style: const TextStyle(fontSize: 20),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditNote(note: note, id: index),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          leading: InkWell(
                            onTap: () {
                              Provider.of<NotesProvider>(context, listen: false)
                                  .deleteNote(note);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Note Deleted !"),
                                ),
                              );

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Some Error",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const CraeteNote();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

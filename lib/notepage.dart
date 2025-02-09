import 'package:flutter/material.dart';
import 'package:note/notes_database.dart';
import 'package:note/notes.dart';

class Notepage extends StatefulWidget {
  const Notepage({super.key});

  @override
  State<Notepage> createState() => _NotepageState();
}

class _NotepageState extends State<Notepage> {
  final notedb = NotesDatabase();
  final getinput = TextEditingController();

  void modifyNote(Note note) {
    getinput.text = note.body;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Modify Task"),
        content: TextField(
          controller: getinput,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              getinput.clear();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              notedb.modified(note, getinput.text);
              Navigator.pop(context);
              getinput.clear();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Remove Task"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              getinput.clear();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              notedb.deleted(note);
              Navigator.pop(context);
              getinput.clear();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void addNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add a Task"),
        content: TextField(
          controller: getinput,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              getinput.clear();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final newNote = Note(body: getinput.text);
              notedb.addNote(newNote);
              Navigator.pop(context);
              getinput.clear();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plan my day"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote, 
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Note>>(
        stream: notedb.readnote, 
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final notes = snapshot.data ?? [];
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.body),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => modifyNote(note), 
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => deleteNote(note), 
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

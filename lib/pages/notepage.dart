import 'package:flutter/material.dart';
import 'package:note/notes_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:note/auth/authservice.dart';
import 'package:note/pages/Loginpage.dart';
import 'package:note/notes.dart';

class Notepage extends StatefulWidget {
  const Notepage({super.key});

  @override
  State<Notepage> createState() => _NotepageState();
}

class _NotepageState extends State<Notepage> {
  final notedb = NotesDatabase();
  final getinput = TextEditingController();
  final service = Authservice();

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
            onPressed: () async {
              await Supabase.instance.client.from('notes').update({
                'body': getinput.text, 
              }).eq('id', note.id); 
              
              Navigator.pop(context);
              getinput.clear();
              setState(() {}); 
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
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await Supabase.instance.client.from('notes').delete().eq('id', note.id); 
              
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

 Future<void> addNote() async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) {
    print("Error: No authenticated user found");
    return;
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Task"),
        content: TextField(
          controller: getinput,
          decoration: const InputDecoration(hintText: "Enter your task"),
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
            onPressed: () async {
              if (getinput.text.trim().isEmpty) {
                return; 
              }

              await Supabase.instance.client.from('notes').insert({
                'user_id': user.id,
                'body': getinput.text.trim(),
              });

              Navigator.pop(context);
              getinput.clear();
              setState(() {});
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}

  void logout() async {
    await service.SignOut();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginpage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plan my day"),
        backgroundColor: const Color.fromARGB(255, 232, 210, 247),
         actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Note>>(
          stream: notedb.readnote(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No notes found"));
            }

            final notes = snapshot.data!;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
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
                );
              },
            );
          }),
    );
  }
}

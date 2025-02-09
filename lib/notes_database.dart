import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:note/notes.dart';

class NotesDatabase {
  final db = Supabase.instance.client.from('notes');

  Future<void> addNote(Note addedNote) async {
    try {
      await db.insert({
        'body': addedNote.body, 
      });
      print("Note added successfully");
    } catch (e) {
      print("Error deleting note: $e");
    }
  }

    final readnote = Supabase.instance.client.from('notes').stream(primaryKey: [
      'id'
    ]).map((data) => data.map((x) => Note.fromMap(x)).toList());

    Future modified(Note prevNote, String Newnote) async {
      await db.update({
        'body': Newnote,
      }).eq('id', prevNote.id!);
    }

    Future deleted(Note note) async {
      await db.delete().eq('id', note.id!);
    }
  }


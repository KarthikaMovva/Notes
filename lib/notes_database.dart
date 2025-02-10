import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:note/notes.dart';

class NotesDatabase {
  final db = Supabase.instance.client.from('notes');

  Future<void> addNote(String newNote) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) {
      print("User not logged in");
      return;
    }

    try {
      final response = await db.insert({
        'user_id': userId,
        'body': newNote,
      });

      print("Note added successfully: $response");
    } catch (error) {
      print("Error adding note: $error");
    }
  }

  Stream<List<Note>> readnote() {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      print("User not logged in, returning empty stream");
      return const Stream.empty();
    }

    return db
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .map((data) {
      print("Fetched Notes: $data");
      return data.map((note) => Note.fromJson(note)).toList();
    });
  }

  Future<void> modified(Note prevNote, String newNote) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) {
      print("User not logged in");
      return;
    }

    try {
      await db
          .update({'body': newNote})
          .eq('id', prevNote.id)
          .eq('user_id', userId);

      print("Note updated successfully!");
    } catch (error) {
      print("Error updating note: $error");
    }
  }

  Future<void> deleted(Note note) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) {
      print("User not logged in");
      return;
    }

    try {
      await db.delete().eq('id', note.id).eq('user_id', userId);

      print("Note deleted successfully!");
    } catch (error) {
      print("Error deleting note: $error");
    }
  }
}

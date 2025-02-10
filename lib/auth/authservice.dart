import 'package:supabase_flutter/supabase_flutter.dart';

class Authservice {
  final SupabaseClient _db = Supabase.instance.client;

  Future<void> Signin(String Email, String Password) async {
  final response= await _db.auth.signInWithPassword(email: Email, password: Password);
      if (response.user != null) {
    print("User logged in: ${response.user!.id}");
  } else {
    print("Error: ${response}");
  }
  }

  Future<void> Signup(String Email, String Password) async {
  final response=await _db.auth.signUp(email: Email, password: Password);
  if (response.user != null) {
    print("User signed up: ${response.user!.id}");
  } else {
    print("Error: ${response}");
  }
  }

  Future<void> SignOut() async {
    await _db.auth.signOut();
  }

  String? getEmail() {
    final Session = _db.auth.currentSession;
    final dbuser = Session?.user;
    return dbuser?.email;
  }
}

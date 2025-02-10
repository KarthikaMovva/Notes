import 'package:flutter/material.dart';
import 'package:note/pages/notepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:note/pages/Loginpage.dart';
import 'package:note/pages/Profilepage.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          final session = snapshot.hasData ? snapshot.data!.session : null;
          if (session != null) {
            print("Current User ID: ${Supabase.instance.client.auth.currentUser?.id}");
            return Notepage();
          } else {
            return Loginpage();
          }
        });
  }
}

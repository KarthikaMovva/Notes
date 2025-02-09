import 'package:flutter/material.dart';
import 'package:note/notepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url:'https://hyxevzmtnrqtzbqgixbb.supabase.co',
    anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5eGV2em10bnJxdHpicWdpeGJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkwMDA0MDgsImV4cCI6MjA1NDU3NjQwOH0.zrAZCQDtOyZFpy_j0k3613TAMac_uvYURoHDAX7zki8' ,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Notepage(),
    );
  }
}

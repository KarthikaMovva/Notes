import 'package:flutter/material.dart';
import 'package:note/auth/authservice.dart';
import 'package:note/pages/Loginpage.dart'; // Ensure this is correctly imported

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final service = Authservice();
  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchEmail();
  }

  void fetchEmail() async {
    final fetchedEmail = await service.getEmail();
    if (mounted) {
      setState(() {
        email = fetchedEmail ?? "No email found";
      });
    }
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
        title: const Text("Profile Page"),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Text(email),
      ),
    );
  }
}

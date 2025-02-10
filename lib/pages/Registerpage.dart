import 'package:flutter/material.dart';
import 'package:note/auth/authservice.dart';
import 'package:note/pages/Loginpage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final service = Authservice();
  final email = TextEditingController();
  final password = TextEditingController();
  final confrimpassword = TextEditingController();

  void signup() async {
    final emailinput = email.text;
    final passwordinput = password.text;
    final confrimpasswordinput = confrimpassword.text;

    if (passwordinput == confrimpasswordinput) {
      try {
        await service.Signup(emailinput, passwordinput);
        Navigator.pop(context);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords did not match")));
      return;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
          TextField(
            controller: email,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          TextField(
            controller: confrimpassword,
            decoration: const InputDecoration(labelText: "Confrim Password"),
            obscureText: true,
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(onPressed: signup, child: const Text("Signup")),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Loginpage())),
              child:
                  const Center(child: Text("Already, have an account? Signin")))
        ],
      ),
    );
  }
}

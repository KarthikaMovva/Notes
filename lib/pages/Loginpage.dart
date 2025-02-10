import 'package:flutter/material.dart';
import 'package:note/auth/authservice.dart';
import 'package:note/pages/Registerpage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final service = Authservice();
  final email = TextEditingController();
  final password = TextEditingController();

  void Login() async {
    final inputmail = email.text;
    final inputpassword = password.text;
    try {
      await service.Signin(inputmail, inputpassword);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
          const SizedBox(height: 12,),
          ElevatedButton(onPressed: Login, child: const Text("Login")),
          const SizedBox(height: 12,),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const Registerpage())),
         child: const Center(child:Text("Don't have an account? Sign up"))
          )
        ],
      ),
    );
  }
}

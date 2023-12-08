import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          //logo
          Icon(
            Icons.person,
            size: 80,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),

          const SizedBox(height: 25),

          //welcome back

          //textfield email

          //password

          //login button

          //navigate to signup
        ],
      ),
    );
  }
}

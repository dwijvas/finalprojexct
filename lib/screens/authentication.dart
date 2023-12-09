import 'package:finalprojexct/screens/HomeScreen.dart';
import 'package:finalprojexct/screens/opening.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            return const HomeScreen();
          }

          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}

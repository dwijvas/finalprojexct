import 'package:finalprojexct/screens/SignupScreen.dart';
import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessageMe',
      theme: ThemeData.dark(),
      home: const SignupScreen(),
    );
  }
}


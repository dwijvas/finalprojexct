import 'package:finalprojexct/screens/SignupScreen.dart';
import 'package:finalprojexct/screens/Splash.dart';
import 'package:finalprojexct/screens/authentication.dart';
import 'package:finalprojexct/screens/opening.dart';
import 'package:finalprojexct/themes/darkmode.dart';
import 'package:finalprojexct/themes/lightmode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
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
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SplashScreen(), // Set the splash screen as the home

    );
  }
}


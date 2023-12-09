import 'package:finalprojexct/screens/authentication.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add any necessary initialization logic here
    // For instance, you might want to load data or perform some checks
    // This is where you might also implement a delay before transitioning to the next screen
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black, Colors.blue]),
        ),
        child: Center(
          // Customize this part with your splash screen content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add your logo or any other introductory elements here
              // For example:
              Icon(
                Icons.group,
                size: 150,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to MessageMe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example NextScreen widget for navigation after splash screen


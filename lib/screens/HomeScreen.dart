import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //logout method
  void logout() {
    FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MessageMe"),
        actions: [
          //logout
          IconButton(onPressed: logout, icon: Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}

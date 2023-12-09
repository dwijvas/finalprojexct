import 'package:finalprojexct/components/textdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final currentUser = FirebaseAuth.instance.currentUser!;

  //editing username
  Future<void> editField(String field) async {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Colors.black54,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 45,),
          //profile icon
          const Icon(Icons.person, size: 64,),

          const SizedBox(height: 8,),

          //email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),

          //details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "My Details",
              style: TextStyle(color: Colors.white),
            ),
          ),

          //username
          UserBox(section: 'Username', text: 'Dwij', onPressed: () => editField('Username') ,),
          //bio
          UserBox(section: 'Bio', text: 'Hello', onPressed: () => editField('Bio') ,),

          const SizedBox(height: 45,),

          //your posts
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "My Posts",
              style: TextStyle(color: Colors.white),
            ),
          ),



        ],
      ),
    );
  }
}

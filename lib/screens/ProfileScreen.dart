import 'package:cloud_firestore/cloud_firestore.dart';
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
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  //editing username

  Future<void> editField(String field) async {
    String newValue = "";
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Edit " + field),
              content: TextField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter new $field",
                      hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (value){
                  newValue = value;
                },
              ),
              actions: [
                //cancel
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel', style: TextStyle(color: Colors.white),),
                ),

                //save
                TextButton(
                  onPressed: () => Navigator.of(context).pop(newValue),
                  child: Text('Save', style: TextStyle(color: Colors.white),),
                ),

              ],
            ),
        );
        //update firestore
    if(newValue.trim().length>0){
      await usersCollection.doc(currentUser.email).update({field: newValue});

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Colors.black54,
      ),
      body: StreamBuilder<DocumentSnapshot> (
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot){
        if(snapshot.hasData) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          return ListView(
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
              UserBox(
                section: 'Username',
                text: userData['username'],
                onPressed: () => editField('username'),
              ),
              //bio
              UserBox(
                section: 'Bio',
                text: userData['bio'],
                onPressed: () => editField('bio') ,
              ),

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

          );

        }else if (snapshot.hasError){
          return Center(child: Text('Error${snapshot.error}'),
          );
        }
        return const Center(child: CircularProgressIndicator(),
        );

    }

    ),
    );
  }
}

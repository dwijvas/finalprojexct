import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojexct/components/drawer.dart';
import 'package:finalprojexct/components/textfields.dart';
import 'package:finalprojexct/screens/ProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalprojexct/components/textpost.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // text controller
  final TextEditingController newPostController = TextEditingController();

  //logout method
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  //postMessage method
  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("Posts").add({
        'UserEmail': currentUser.email,
        'PostMessage': newPostController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }
    newPostController.clear();
  }

  //curretn user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //profile page method
  void openProfile() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text("MessageMe"),
      ),

      drawer: AppDrawer(
        onTapLogout: logout,
        onTapProfile: openProfile,
      ),
      body: Center(
        child: Column(
          children: [
            //MessageMe
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Posts')
                    .orderBy('TimeStamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                      final post = snapshot.data!.docs[index];
                      return TextPost(
                          msg: post['PostMessage'],
                          user: post['UserEmail'],
                          postID: post.id,
                          likes: List<String>.from(post['Likes'] ?? []),
                      );
                      },
                    );
                  } else if(snapshot.hasError){
                    return Center(child: Text('Error:${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },

              ),
            ),

            //text posts
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(child: MyTextField(
                    controller: newPostController,
                    hintText: 'Post a message...',
                    obscureText: false,
                  )),

                  //post button
                  IconButton(onPressed: postMessage, icon: const Icon(Icons.arrow_upward))

                ],
              ),
            ),
            //current user
            Text(currentUser.email!),
          ],
        ),
      ),
    );
  }
}

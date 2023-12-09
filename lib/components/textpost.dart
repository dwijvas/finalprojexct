import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojexct/components/likebutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextPost extends StatefulWidget {
  final String msg;
  final String user;
  final String postID;
  final List<String> likes;
  const TextPost({
    super.key,
    required this.msg,
    required this.user,
    required this.postID,
    required this.likes,
  });

  @override
  State<TextPost> createState() => _TextPostState();
}

class _TextPostState extends State<TextPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }
  //toggle likes method
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef=
    FirebaseFirestore.instance.collection('Posts').doc(widget.postID);

    if (isLiked){
    //adding user to like field
      postRef.update({
        'Likes' : FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes' : FieldValue.arrayRemove([currentUser.email])
      });
    //removing user from like field
    }

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(7),
      ),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            children: [
              //like
              LikeButton(
                  isLiked: isLiked,
                  onTap: toggleLike,
              ),

              const SizedBox(height: 5),

              Text(
                  widget.likes.length.toString(),
                  style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.user,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8,),
              Text(widget.msg),
            ],
          )
        ],

      ),
    );
  }
}

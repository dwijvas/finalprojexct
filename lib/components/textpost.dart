
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojexct/components/commentButton.dart';
import 'package:finalprojexct/components/comments.dart';
import 'package:finalprojexct/components/likebutton.dart';
import 'package:finalprojexct/help/helpermethod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextPost extends StatefulWidget {
  final String msg;
  final String user;
  final String time;
  final String postID;
  final List<String> likes;
  const TextPost({
    super.key,
    required this.msg,
    required this.user,
    required this.postID,
    required this.likes,
    required this.time,
  });

  @override
  State<TextPost> createState() => _TextPostState();
}

class _TextPostState extends State<TextPost> {
  final commentController = TextEditingController();
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


  //adding comments method
  void addComment(String commentText){
    FirebaseFirestore.instance.collection("Posts").doc(widget.postID).collection("Comments").add({
      "CommentText" : commentText,
      "CommentedBy" : currentUser.email,
      "CommentTime" : Timestamp.now()
    });

  }


  //dialog box to add comment

  void showCommentBox(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Add Comment"),
      content: TextField(
        controller: commentController,
        decoration: InputDecoration(hintText: "Write your comment..."),
      ),
      actions: [
        //cancel
        TextButton(onPressed: () => Navigator.pop(context),

          child: Text("Cancel"),
        ),
        //save
        TextButton(onPressed: () => addComment(commentController.text),
            child: Text("Post Comment"),
        ),


      ],
    ),);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.time,
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12),
                  ),
                  Text(
                    ' • ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12),
                  ),
                  Text(
                    widget.user,
                    style: TextStyle(
                        color: Colors.white24,
                        fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              Text(widget.msg),
            ],
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
            const SizedBox(width: 8,),

            Column(
              children: [
                //comment
                CommentButton(onTap: showCommentBox),

                const SizedBox(height: 5),

                Text(
                  '0',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ],

          ),
          const SizedBox(height: 8,),
          //comments
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Posts").doc(widget.postID).collection("Comments").orderBy("CommentTime", descending: true).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    final commentData = doc.data() as Map<String, dynamic>;
                    return Comments(text: commentData["CommentText"],
                        user: commentData["CommentedBy"],
                        time: formatData(commentData["CommentTime"]),
                    );
                  }).toList(),
                );
              },


          )
        ],



        

      ),
    );
  }
}

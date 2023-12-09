import 'package:flutter/material.dart';

class TextPost extends StatelessWidget {
  final String msg;
  final String user;
  const TextPost({
    super.key,
    required this.msg,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(7),
      ),
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8,),
              Text(msg),
            ],
          )
        ],

      ),
    );
  }
}

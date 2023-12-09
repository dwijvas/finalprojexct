import 'package:flutter/material.dart';

class UserBox extends StatelessWidget {
  final String text;
  final String section;
  final void Function()? onPressed;
  const UserBox({super.key, required this.section, required this.text, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  section,
                  style: TextStyle(color: Colors.grey),
              ),

              //edit
              IconButton(onPressed: onPressed, icon: Icon(Icons.edit, color: Colors.grey,),
              )
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}

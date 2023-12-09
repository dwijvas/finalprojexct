import 'package:finalprojexct/components/drawertile.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final void Function()? onTapProfile;
  final void Function()? onTapLogout;
  final void Function()? onTapChat;
  const AppDrawer({super.key, required this.onTapLogout, required this.onTapProfile,required this.onTapChat});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column( children: [
            //header
            DrawerHeader(
              child: Icon(Icons.group,
                color: Colors.white54,
                size: 64,
              ),
            ),

            //homepage
            DrawerTile(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            //chat
            DrawerTile(icon: Icons.chat, text: 'Messenger', onTap: onTapChat,),

            //profile
            DrawerTile(icon: Icons.person, text: 'User Settings', onTap: onTapProfile,),

          ],

          ),




          //logout
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: DrawerTile(icon: Icons.logout_rounded, text: 'Log Out', onTap: onTapLogout,),
          ),
        ],
      ),
    );
  }
}
